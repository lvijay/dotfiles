#z,a,f='0**'
#for c in input():
# for v in bin(128|ord(c))[3:]:a+=f' {z+z*(z==v)} '*(f!=v)+z;f=v
#print(a[2:])

r=str.replace
r(r(r(r(''.join([bin(128|ord(c))[3:]for c in input()]),'01','0x0'),'10','0y0'),'x',' 0 '),'y',' 00 ')
('xy'[q[0]=='0']+q[1:].replace('01','0x1').replace('10','0y0')).replace('x',' 0 ').replace('y',' 00 ').replace('1','0')
def dwim(s):
 z,a,f='0**'
 print(''.join([bin(128|ord(c))[3:]for c in s]))
 for c in s:
  for v in bin(128|ord(c))[3:]:
   a+=f' {z+z*(v==z)} '*(f!=v)+z;f=v
 return(a[2:])
