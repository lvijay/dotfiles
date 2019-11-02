a,z='X0'
s=''.join([bin(0x80|ord(c))[3:]for c in input()])
while s:f=s[0];j=s.find('01'[f==z]);j=[len(s),j][j>=0];s=s[j:];a+='%s %s '%(z+['',z][f==z],z*j)
print(a[1:-1])
