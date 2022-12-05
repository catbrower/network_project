import scipy.integrate as spi
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from functions import mutualistic, random_matrix, mutalistic_matrix

def g_from_kd(k, d):
    return (2*d*k + np.sqrt(8*d*k + 1) + 1) / (2*k)

N = 20
_A = random_matrix(N, 0.1)
A = mutalistic_matrix(N, 0.25)
g = g_from_kd(1, 0.5)
G = A * g
print(np.mean(sum(A)))
print(np.sum(A, axis=0))
print(np.sum(A, axis=1))

def system_eqns(t, Y):
    d = 0.5
    s = 1
    a = 1
    dY = np.zeros(len(Y))
    for i in range(len(Y)):
        dY[i] = mutualistic(i, Y, A, G, d, s, a)
    return dY

def diff_eqs_pendulum(t, Y): 
    dY = np.zeros((3))
    dY[0] =  Y[1]
    dY[1] = -Y[0]
    dY[2] =  Y[0]*Y[1]
    return dY

t_start, t_end = 0.0, 20.0

case = 'B'

# pendulum
if case == 'A':
    Y = np.array([0.1, 1.0, 0.0]); 
    Yres = spi.solve_ivp(diff_eqs_pendulum, [t_start, t_end], Y, method='RK45', max_step=0.01)

if case == 'B':
    Y = np.ones(N) * 1
    # print('Y initial:'); print(Y); print()
    Yres = spi.solve_ivp(system_eqns, [t_start, t_end], Y, method='RK45', max_step=0.01)

#---- graphics ---------------------
yy = pd.DataFrame(Yres.y).T
tt = np.linspace(t_start,t_end,yy.shape[0])
fig, ax = plt.subplots()
ax.set_title('Integration Example')
ax.set_ylabel('x')
ax.set_xlabel('time')
plt.grid(axis='y')
with plt.style.context('fivethirtyeight'): 
    plt.figure(1, figsize=(20,5))
    ax.plot(tt,yy,lw=2, alpha=0.5)
    
    # for j in range(3):
    #     plt.fill_between(tt,yy[j],0, alpha=0.2, label='y['+str(j)+']')

    # plt.legend(prop={'size':20})
plt.show(block=True)