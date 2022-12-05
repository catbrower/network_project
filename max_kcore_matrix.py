import ray
import scipy.integrate as spi
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import networkx as nx

from functions import *

#####
# Hyperparams
#####

def get_max_core(graph):
    n = 0
    size = float('inf')
    while size > 0:
        n += 1
        size = len(nx.k_core(graph, n).adj)
        
    return n
    

num_threads = 16
N = 100
d = 2

for _ in range(20):
    A = mutalistic_matrix(N, 0.02)
    G = nx.Graph(A)
    max_core = get_max_core(G)
    print(max_core)

print()