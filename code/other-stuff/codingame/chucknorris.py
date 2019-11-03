a,z='X0'
s=''.join([bin(0x80|ord(c))[3:]for c in input()])
while s:f=s[0]==z;j=s.find('01'[f]);j=[len(s),j][j>=0];s=s[j:];a+=f' {[z,z+z][f]} {z*j}'
print(a[2:])
