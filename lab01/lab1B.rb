#   0x08048c49 <+101>:	call   0x8048840 <__isoc99_scanf@plt>
#   0x08048c4e <+106>:	mov    eax,DWORD PTR [esp+0x1c]
#   0x08048c52 <+110>:	mov    DWORD PTR [esp+0x4],0x1337d00d
#   0x08048c5a <+118>:	mov    DWORD PTR [esp],eax
#   0x08048c5d <+121>:	call   0x8048a74 <test>


#	Starting program: /levels/lab01/lab1B
#	.---------------------------.
#	|-- RPISEC - CrackMe v2.0 --|
#	'---------------------------'
#
#	Password: 00000069


#	[----------------------------------registers-----------------------------------]
#	EAX: 0x45 ('E')
#	EBX: 0xb7fca000 --> 0x1a9da8
#	ECX: 0xb7fcb8a4 --> 0x0
#	EDX: 0x1337d00d
#	[-------------------------------------code-------------------------------------]
#	   0x8048a77 <test+3>:	sub    esp,0x28
#	   0x8048a7a <test+6>:	mov    eax,DWORD PTR [ebp+0x8]
#	   0x8048a7d <test+9>:	mov    edx,DWORD PTR [ebp+0xc]
#	=> 0x8048a80 <test+12>:	sub    edx,eax

# EDX: 0x1337cfc8 (0x1337d00d - 0x00000069 ['E'])


# First iteration of XOR encryption (XOR'ing with 0x51 ['Q']):
#
# [----------------------------------registers-----------------------------------]
# EAX: 0x20f8352b
# EBX: 0xb7fca000 --> 0x1a9da8
# ECX: 0xb ('\x0b')
# EDX: 0x51 ('Q')
# ESI: 0x0
# EDI: 0x0
# EBP: 0xbffff6a8 --> 0xbffff6d8 --> 0xbffff708 --> 0x0
# ESP: 0xbffff670 --> 0xbffff68b ("Q}|u`sfg~sf{}|a3")
# EIP: 0x8048a18 (<decrypt+97>:	xor    eax,edx)
# EFLAGS: 0x286 (carry PARITY adjust zero SIGN trap INTERRUPT direction overflow)
# [-------------------------------------code-------------------------------------]
#    0x8048a10 <decrypt+89>:	movzx  eax,BYTE PTR [eax]
#    0x8048a13 <decrypt+92>:	mov    edx,eax
#    0x8048a15 <decrypt+94>:	mov    eax,DWORD PTR [ebp+0x8]
# => 0x8048a18 <decrypt+97>:	xor    eax,edx
#    0x8048a1a <decrypt+99>:	lea    ecx,[ebp-0x1d]
#    0x8048a1d <decrypt+102>:	mov    edx,DWORD PTR [ebp-0x28]
#    0x8048a20 <decrypt+105>:	add    edx,ecx
#    0x8048a22 <decrypt+107>:	mov    BYTE PTR [edx],al
# [------------------------------------stack-------------------------------------]
# 0000| 0xbffff670 --> 0xbffff68b ("Q}|u`sfg~sf{}|a3")
# 0004| 0xbffff674 --> 0xbffff68c ("}|u`sfg~sf{}|a3")
# 0008| 0xbffff678 --> 0x0
# 0012| 0xbffff67c --> 0xb7fca000 --> 0x1a9da8
# 0016| 0xbffff680 --> 0x0
# 0020| 0xbffff684 --> 0x10
# 0024| 0xbffff688 --> 0x51000000 ('')
# 0028| 0xbffff68c ("}|u`sfg~sf{}|a3")
# [------------------------------------------------------------------------------]
#


#	0x8048a2b <decrypt+116>:	cmp    eax,DWORD PTR [ebp-0x24]
#   0x8048a2e <decrypt+119>:	jb     0x8048a08 <decrypt+81>
#   0x8048a30 <decrypt+121>:	mov    DWORD PTR [esp+0x4],0x8048d03
#
#   0004| 0xbffff674 --> 0x8048d03 ("Congratulations!")


# Hence, the key can be computed as: 'C' ^ 'Q' = 'C'.ord ^ 0x51.
# TODO: small English write-up of walkthrough.


flag = '/tmp/lab1A.pass'

%x{(ruby -e "puts #{0x1337d00d - ('C'.ord ^ 0x51)}"; echo 'cat /home/lab1A/.pass > #{flag}') | /levels/lab01/lab1B}
puts `cat #{flag}`
