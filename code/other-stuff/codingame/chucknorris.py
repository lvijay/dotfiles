z='0'
s=''.join([bin(0x80|ord(c))[3:]for c in input()])
f=s[0];a=f'{[z,z+z][f==z]} '
for v in s:
 if f!=v:a,f=a+f' {[z,z+z][v==z]} ',v
 a+=z
print(a)
