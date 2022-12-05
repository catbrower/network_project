from functools import partial

import numpy as np
import matplotlib.pyplot as plt

from functions import *

def to_int(array):
    return [int(x) for x in array]

data = open('data/set_1.csv','r').readlines()
data = np.array([to_int(x.split(',')) for x in data])

A = mutalistic_matrix(100, 0.1)

degrees = sum(data)
A_degrees = sum(A)

probabilities = []
for i in range(1, max(degrees) + 1):
    p = len([x for x in degrees if x == i]) / len(degrees)
    probabilities.append((i, p))

pk = np.log([x[1] for x in probabilities])
k = np.log([x[0] for x in probabilities])

infs = np.argwhere(pk != float('-inf'))
pk = pk[infs].reshape(-1)
k = k[infs].reshape(-1)

fig, ax = plt.subplots()
ax.set_title('Mutualistic Degree Distribution')
ax.set_ylabel('log(p(k))')
ax.set_xlabel('log(k)')
plt.scatter(k, pk)
plt.plot(np.unique(k), np.poly1d(np.polyfit(k, pk, 1))(np.unique(k)), c='k')
plt.show(block=True)