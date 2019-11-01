z,j='0X'
l=lambda x:z*(7-len(x))+x
a,s='',''.join([l(bin(ord(c))[2:])for c in input()])
while s:f=s[0];j=s.find('01'[f==z]);j=[len(s),j][j>=0];s=s[j:];a+='%s %s '%(z+['',z][f==z],z*j)
print(a[:-1])
