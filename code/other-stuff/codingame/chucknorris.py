z,a,f='0__'
for v in''.join([bin(128|ord(c))[3:]for c in input()]):
 if f!=v:a,f=a+f' {[z,z+z][v==z]} ',v
 a+=z
print(a[2:])
