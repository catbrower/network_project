import numpy as np
import networkx as nx
import matplotlib.pyplot as plt

A = np.loadtxt('graph_data/bipartite_d2.csv', delimiter=',')

fig, ax = plt.subplots()
ax.set_title('')
ax.set_xlabel('K')
ax.set_ylabel('<x*>')
ax.plot(A[0], A[1])

plt.show(block=True)