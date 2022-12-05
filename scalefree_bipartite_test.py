import numpy as np
import networkx as nx
from functions import *

N = 15
G = nx.scale_free_graph(N)
adj = nx.to_numpy_array(G)
sparse = nx.to_scipy_sparse_matrix(G)
bipartite = nx.bipartite.from_biadjacency_matrix(sparse)
k_max = get_max_core(bipartite)
# nx.bipartite.from

print()