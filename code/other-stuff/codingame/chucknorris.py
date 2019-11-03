z,a,f='0 _'
for c in input():
 for v in bin(128|ord(c))[3:]:
  if f!=v:a,f=a+f' {[z,z+z][v==z]} ',v
  a+=z
print(a[2:])
