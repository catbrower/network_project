import numpy as np
import networkx as nx
import matplotlib.pyplot as plt

N = 87
x = np.zeros(shape=(N, N))
degrees = (N - np.random.power(N/2, size=N) * N + 1).astype(np.int32)
indecies = np.arange(0, N, 1)

for i in range(N):
    x[i, np.random.choice(indecies, size=degrees[i])] = 1

for i in range(N):
    for j in range(N):
        if i > j or x[i, j] == 0:
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

plt.hist(sum(x))
plt.show(block=True)

