import ray
import scipy.integrate as spi
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from functions import *

#####
# Hyperparams
#####

num_threads = 16
d = 2
N = 10
_A = nx.bipartite.random_graph(N, N, 0.5)
A = load_data()
N = A.shape[0]
kmax = get_max_core(_A)
print(kmax)

def g_from_kd(k, d):
    return (2*d*k + np.sqrt(8*d*k + 1) + 1) / (2*k)

@ray.remote
def mutualistic_batch(indecies, Y, A, G, d, s, a):
    results = np.zeros(shape=N)
    for i in indecies:
        results[i] = mutualistic(i, Y, A, G, d, s, a)
    return results

def ray_mutualistic(Y, A, G, d, s, a):
    jobs = []
    step = int(N / num_threads)
    for i in range(num_threads):
        indecies = list(range(i * step, (i + 1) * step))
        jobs.append(mutualistic_batch.remote(indecies, Y, A, G, d, s, a))

    job_results = ray.get(jobs)

    # recombine jobs
    results = np.zeros(N)
    for job_result in job_results:
        results += job_result
    return np.array([round(x, 3) for x in results])

def system_eqns(t, Y, G):
    s = 1
    a = 1
    # dY = np.zeros(len(Y))
    # for i in range(len(Y)):
    #     dY[i] = ray_mutualistic(i, Y, A, G, d, s, a)
    dY = ray_mutualistic(Y, A, G, d, s, a)
    return dY

#####
# Solve
#####
# Values for the real data full graph test:
# k,                mean
#6.000000000000004 0.9218352030299326

means = []
ks = []
for g in np.linspace(g_from_kd(kmax+1, d), d + 1, 10):
    _G = np.ones(shape=(N, N)) * g
    # g = gamma_mean - step

    k = (g + d) / ((g - d) ** 2)
    t_start, t_end = 0.0, 100
    Y = np.ones(N) * 1
    # print('Y initial:'); print(Y); print()
    Yres = spi.solve_ivp(system_eqns, [t_start, t_end], Y, method='RK45', max_step=0.01, args=[_G])
    mean_diff = np.mean(Yres.y, axis=0)[0:-1] - np.mean(Yres.y, axis=0)[1:]
    min_density = min(Yres.y[:, -1])
    max_density = max(Yres.y[:, -1])

    # normally this is corrected but I took it out
    mean = np.mean(Yres.y[:, -1]) / (g - d)
    means.append(mean)
    ks.append(k)
    print(k, mean)

data = np.array([ks, means])
np.savetxt(f'graph_data/bipartite_k%s_d%s_%s.csv' % (str(int(kmax)), str(d), str(np.random.random())), data, delimiter=',')
plt.plot(ks, means)
plt.show(block=True)