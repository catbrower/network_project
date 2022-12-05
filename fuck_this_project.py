import numpy as np
from functions import *

data = open('data/set_1.csv','r').readlines()
data = np.array([to_int(x.split(',')) for x in data])

def get_k_core(graph, k):
    shape = graph.shape
    did_remove = True

    while did_remove:
        did_remove = False
        for i in range(shape[0]):
            if 0 < sum(graph[i, :]) < k:
                graph[i, :] = 0
                did_remove = True

        for j in range(shape[1]):
            if 0 < sum(graph[:, j]) < k:
                graph[:, j] = 0
                did_remove = True
    return graph

cores = []
for k in range(1, 5):
    data = open('data/set_1.csv','r').readlines()
    data = np.array([to_int(x.split(',')) for x in data])
    kcore = get_k_core(data, k)
    
    cores.append(np.sum(kcore))


print()