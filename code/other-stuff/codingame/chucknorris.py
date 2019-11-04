from re import*
print(sub('1','0',sub('^1','0 0',sub('^0','00 0',sub('0(1+)',r'0 0 \1',sub('1(0+)',r'1 00 \1',''.join([bin(128|ord(c))[3:]for c in input()])))))))
