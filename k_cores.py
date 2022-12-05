from scipy.sparse import csr_matrix
from scipy.optimize import fixed_point
import numpy as np
import networkx as nx

def random_matrix(N, p):
    result = np.zeros(shape=(N, N))
    for i in range(N):
        for j in range(N):
            if np.random.random() < p and i != j and result[j, i] == 0:
                result[i, j] = 1
    return result

def f(i, xs, A, G, d, s, a):
    N = len(A)
    result = -d*xs[i] - s*xs[i]**2

    for j in range(N):
        inner_sum = 0
        for k in range(N):
            inner_sum += A[i, k] * xs[k]
        result += A[i, j] * G[i, j] * ((xs[i] * xs[j]) / (a + inner_sum))

    return result

def fixed_point_eqn(i, xs, A, G, g, d, s, a):
    N = len(A)
    result = -d/s

    for j in range(N):
        inner_sum = 0
        for k in range(N):
            inner_sum += A[i, k] * xs[k]
        result += A[i, j] * G[i, j] * (xs[j] / (a + inner_sum))

    return (g / s) * result

def g_from_kd(k, d):
    return (2*d*k + np.sqrt(8*d*k + 1) + 1) / (2*k)

def to_int(array):
    return [int(x) for x in array]

data = open('data/set_1.csv','r').readlines()
data = np.array([to_int(x.split(',')) for x in data])

# restructure the data, pollonators, plants
num_pollenators = data.shape[0]
N = np.sum(data.shape)
data_A = np.zeros(shape=(N, N))
for i in range(data.shape[0]):
    for j in range(data.shape[1]):
        # The paper talks about directed graphs but the data set given is not that way
        data_A[i, j + num_pollenators] = 1
        data_A[j + num_pollenators, i] = 1

# mat = csr_matrix(data)
# A = nx.bipartite.from_biadjacency_matrix(mat)
# A = nx.Graph(data_A)
N = 100
data_A = random_matrix(100, 0.1)
A = nx.Graph(data_A)

cores = []
shells = []
core_n = 0
core_size = float('inf')
while core_size > 0:
    core = nx.k_core(A, core_n)
    shell = nx.k_shell(A, core_n)
    core_size = len(core.edges)
    cores.append(core)
    core_n += 1

d = 4
s = 1
a = 1
delta = 0
mean = 1

results = []
for k in np.linspace(1, 5, 50):
    G = np.random.uniform(mean - delta, mean + delta, size=(N, N))
    # G[np.argwhere(G < 0)] = 0
    g = np.mean(np.mean(G))
    new_g = g_from_kd(k, d)
    G = G * (new_g / g)
    g = np.mean(np.mean(G))

    def optimize_fixed_point(_xs):
        results = []
        for i in range(len(_xs)):
            results.append(fixed_point_eqn(i, _xs, data_A, G, new_g, d, s, a))
        return np.array(results)
    xs = fixed_point(optimize_fixed_point, np.ones(shape=N))

    k = (g + d) / (g - d) ** 2
    print(k, np.mean(xs) / (g - d))
    results.append((g, np.mean(xs)))


print()