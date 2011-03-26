from matplotlib import *
from pylab import *
import numpy as np

index_file = np.loadtxt("../data/track_info.dat")
index2 = index_file[:,0];
index1 = index_file[:,1];

index1 = index1 - 1;
index2 = index2 - 1;

select1_file = np.loadtxt("../data/select1.dat")
data1_px_0    =  select1_file[:,0]
data1_pz_0    =  select1_file[:,1]
data1_ts_re   =  select1_file[:,2]
data1_ts_im   =  select1_file[:,3]
data1_x_0     =  select1_file[:,4]
data1_z_0     =  select1_file[:,5]
data1_px      =  select1_file[:,6]
data1_pz      =  select1_file[:,7]
data1_M_re    =  select1_file[:,8]
data1_M_im    =  select1_file[:,9]
data1_n_pass_x = select1_file[:,10]
data1_n_pass_z = select1_file[:,11]
data1_err     =  select1_file[:,12]
data1_type    =  select1_file[:,13]



select2_file = np.loadtxt("../data/select2.dat")
data2_px_0    =  select2_file[:,0]
data2_pz_0    =  select2_file[:,1]
data2_ts_re   =  select2_file[:,2]
data2_ts_im   =  select2_file[:,3]
data2_x_0     =  select2_file[:,4]
data2_z_0     =  select2_file[:,5]
data2_px      =  select2_file[:,6]
data2_pz      =  select2_file[:,7]
data2_M_re    =  select2_file[:,8]
data2_M_im    =  select2_file[:,9]
data2_n_pass_x = select2_file[:,10]
data2_n_pass_z = select2_file[:,11]
data2_err     =  select2_file[:,12]
data2_type    =  select2_file[:,13]

print "Length of file \'select1.dat\': " + str(len(data1_px_0))
print "Length of file \'select2.dat\': " + str(len(data2_px_0))


figure(figsize=(10,6), frameon=False)
ax = subplot(111, frameon=True)

hold(True)


cl = []
si = []
for i in range(len(data1_type)):
    if data1_type[i] == 1:
        cl.append('r')
    elif data1_type[i] == 2:
        cl.append('b')
    elif data1_type[i] == 3:
        cl.append('g')
    elif data1_type[i] == 4:
        cl.append('k')
    si.append(  log10(data1_M_re[i]**2+data1_M_im[i]**2) + 60 )


scatter(data1_pz, data1_px, c=cl, marker='s', s=si)



cl = []
si = []
for i in range(len(data2_type)):
    if data2_type[i] == 1:
        cl.append('r')
    elif data2_type[i] == 2:
        cl.append('b')
    elif data2_type[i] == 3:
        cl.append('g')
    elif data2_type[i] == 4:
        cl.append('k')
    si.append(  log10(data1_M_re[i]**2+data1_M_im[i]**2) + 60 )

scatter(data2_pz, data2_px, c=cl, marker='o', s=si)



#scatter(data2_pz_0, data2_px_0, c='y')
#scatter(data1_pz_0, data1_px_0, c='g')

#plot([ data1_pz[index1[1]], data2_pz[1] ], [ data1_px[index1[1]], data2_px[1] ], 'r')


for i in range(0, len(data2_px)-1):
    if data1_type[index1[i]] == 1:
        plot([ data1_pz[index1[i]], data2_pz[i] ], [ data1_px[index1[i]], data2_px[i] ], 'r' );
    if data1_type[index1[i]] == 2:
        plot([ data1_pz[index1[i]], data2_pz[i] ], [ data1_px[index1[i]], data2_px[i] ], 'b' );
    if data1_type[index1[i]] == 3:
        plot([ data1_pz[index1[i]], data2_pz[i] ], [ data1_px[index1[i]], data2_px[i] ], 'g' );
    if data1_type[index1[i]] == 4:
        plot([ data1_pz[index1[i]], data2_pz[i] ], [ data1_px[index1[i]], data2_px[i] ], 'k' );


xlim([-1, 1])
ylim([0, 1])

plt.savefig('/home/timy/Desktop/fig/trend.png')

plt.show()