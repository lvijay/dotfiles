z,a,f='0**'
for c in input():
 for v in bin(128|ord(c))[3:]:a+=f' {z+z*(v==z)} '*(f!=v)+z;f=v
print(a[2:])
