z,s,a,*f='0',''.join([bin(0x80|ord(c))[3:]for c in input()]),''
for v in s:
 if f!=v:a,f=a+f' {[z,z+z][v==z]} ',v
 a+=z
print(a[1:])
