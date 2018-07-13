# The instructions below equate to the condition: ptrace(PTRACE_TRACEME, 0, 1, 0) == -1.
# This is a bit of anti-debug code to prevent debugging of the main part of auth().
#
#    0x08048a5f <+80>:	mov    DWORD PTR [esp+0xc],0x0
#    0x08048a67 <+88>:	mov    DWORD PTR [esp+0x8],0x1
#    0x08048a6f <+96>:	mov    DWORD PTR [esp+0x4],0x0
#    0x08048a77 <+104>:	mov    DWORD PTR [esp],0x0
#    0x08048a7e <+111>:	call   0x8048870 <ptrace@plt>
#    0x08048a83 <+116>:	cmp    eax,0xffffffff
#    0x08048a86 <+119>:	jne    0x8048ab6 <auth+167>
#
#    This jump will ultimately lead to a swift exit.
#    Hence, we will need to modify the return value stored in EAX to take the jump (i.e. "we are not debugging"):
#
#    gdb-peda$ set $eax = 0
#    gdb-peda$ n
#
#    => 0x8048a86 <auth+119>:	jne    0x8048ab6 <auth+167>
#    | 0x8048a88 <auth+121>:	mov    DWORD PTR [esp],0x8048d08
#    | 0x8048a8f <auth+128>:	call   0x8048810 <puts@plt>
#    | 0x8048a94 <auth+133>:	mov    DWORD PTR [esp],0x8048d2c
#    | 0x8048a9b <auth+140>:	call   0x8048810 <puts@plt>
#    |->   0x8048ab6 <auth+167>:	mov    eax,DWORD PTR [ebp+0x8]
#          0x8048ab9 <auth+170>:	add    eax,0x3
#          0x8048abc <auth+173>:	movzx  eax,BYTE PTR [eax]
#          0x8048abf <auth+176>:	movsx  eax,al
#                                                                     JUMP is taken
#


# TODO: write-up if I can be bothered - a lot of jumps to follow.

user   = 'AAAAAA'
serial = (user[3].ord ^ 0x1337) + 0x5eeded

if user.size <= 5 || user[3].ord <= 0x1f
	puts "[-] Invalid username."
	exit
end

user.chars.each do |c|
	ecx = serial ^ c.ord
	edx = (ecx * 0x88233b2b) >> 32
	eax = ((ecx - edx) >> 1) + edx
	eax = (eax >> 0xA) * 0x539
	eax = ecx - eax

	serial += eax
end

flag = '/tmp/lab1end.pass'

%x{(ruby -e 'puts "#{user}"; puts "#{serial}"'; echo 'cat /home/lab1end/.pass > #{flag}') | /levels/lab01/lab1A}
puts `cat #{flag}`


# Output:
# ------------------------------------------------
# lab1A@warzone:/levels/lab01$ ruby /tmp/exploit.rb
# 1uCKy_Gue55
