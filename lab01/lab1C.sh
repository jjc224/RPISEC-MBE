#!/usr/bin/env bash

# Very simple crackme which just compares input against 0x149a (5274):
# 	0x080486fe <+81>: cmp eax,0x149a 

flag=/tmp/lab1B.pass    # n0_str1ngs_n0_pr0bl3m

(python -c 'print 0x149a'; echo "cat /home/lab1B/.pass > $flag") | /levels/lab01/lab1C
&& echo "[+] Passfile saved to $flag."

