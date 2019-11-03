z,a,f='0 _'
for c in input():
 for v in bin(128|ord(c))[3:]:a+=[f' {[z,z+z][v==z]} ',''][f==v]+z;f=v
print(a[2:])
