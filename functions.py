import numpy as np
import networkx as nx
import scipy.integrate as spi

def get_max_core(graph):
    n = 0
    size = float('inf')
    while size > 0:
        n += 1
        size = len(nx.k_core(graph, n).adj)
        
    return n

def to_int(array):
    return [int(x) for x in array]

def load_data():
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

    return data_A

# Implementation of eqn 1 from the literature
def mutualistic(i, xs, A, G, d, s, a):
    N = len(A)
    result = -d*xs[i] - s*xs[i]**2

    for j in range(N):
        if A[i, j] == 0:
            continue
        
        inner_sum = 0
        for k in range(N):
            inner_sum += A[i, k] * xs[k]
        result += A[i, j] * G[i, j] * ((xs[i] * xs[j]) / (a + inner_sum))

    return result

# Implementation of eqn 22 from the literature
def mutualistic_fixed_point_eqn(i, xs, A, G, g, d, s, a):
    N = len(A)
    result = -d/s

    for j in range(N):
        inner_sum = 0
        for k in range(N):
            inner_sum += A[i, k] * xs[k]
        result += A[i, j] * G[i, j] * (xs[j] / (a + inner_sum))

    return (g / s) * result

# simple random matrix generator
def random_matrix(N, p):
    result = np.zeros(shape=(N, N))
    for i in range(N):
        for j in range(N):
            if np.random.random() < p and i != j and result[j, i] == 0:
                result[i, j] = 1
    return result

# simple mutualistic network, min degree = 1
def mutalistic_matrix(N, p):
    A = random_matrix(N, p)
    for i in range(len(A)):
        if sum(A[i, :]) == 0:
            # Maintain Aij != Aji
            js = [j for j in range(N) if A[i, j] == 0 and i != j]
            if len(js) == 0:
                raise "Cannot create matrix"
            else:
                j = np.random.choice(js)
                A[i, j] = 1
    return A

def scale_free_network(N):
    x = np.zeros(shape=(N, N))
    degrees = (N - np.random.power(N/2, size=N) * N + 1).astype(np.int32)
    indecies = np.arange(0, N, 1)

    for i in range(N):
        x[i, np.random.choice(indecies, size=degrees[i])] = 1

    for i in range(N):
        for j in range(N):
            if i < j or x[i, j] == 0:
                continue
            elif i == j:
                x[i, j] = 0
            elif x[i, j] == x[j, i]:
                if np.random.random() > 0.5 and degrees[i] > 1:
                    x[i, j] = 0
                else:
                    x[j, i] = 0

    for i in range(N):
        for j in range(N):
            if i == j:
                continue

            if sum(x[i]) == 0:
                indecies = [k for k in range(N) if x[k, i] == 0]
                x[i, np.random.choice(indecies)] = 1

            if sum(x[:, i]) == 0:
                indecies = [k for k in range(N) if x[i, k] == 0]
                x[np.random.choice(indecies), i] = 1
    return x

def system_eqns(t, Y, A, G, d, s, a):
    dY = np.zeros(len(Y))
    for i in range(len(Y)):
        dY[i] = mutualistic(i, Y, A, G, d, s, a)
    # dY = ray_mutualistic(Y, A, G, d, s, a)
    return dY

def solve_for_g(N, A, g, d, s, a, t_start=0, t_end=10):
    _G = np.ones(shape=(N, N)) * g
    # g = gamma_mean - step

    k = (g + d) / ((g - d) ** 2)
    Y = np.ones(N) * 1
    # print('Y initial:'); print(Y); print()
    Yres = spi.solve_ivp(system_eqns, [t_start, t_end], Y, method='RK45', max_step=0.01, args=[A, _G, d, s, a])
    mean_diff = np.mean(Yres.y, axis=0)[0:-1] - np.mean(Yres.y, axis=0)[1:]
    min_density = min(Yres.y[:, -1])
    max_density = max(Yres.y[:, -1])

    # normally this is corrected but I took it out
    mean = np.mean(Yres.y[:, -1]) / (g - d)
    return mean