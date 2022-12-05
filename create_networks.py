import numpy as np
from pymongo import MongoClient
import networkx as nx
from scipy import optimize

from functions import *

N = 40
client = MongoClient('localhost', 27017)

def random_bipartite():
    for _ in range(100):
        p = np.random.random()
        G = nx.bipartite.random_graph(N, N, p)
        adj = nx.to_numpy_array(G)

        # Stats
        avg_degree = np.sum(adj) / (2 * N)
        std_degree = np.std(sum(adj))
        max_core = get_max_core(G)

        client.network_project.networks.insert_one({
            'type': 'random_bipartite',
            'p': p,
            'N': N,
            'avg_degree': avg_degree,
            'std_degree': std_degree,
            'max_core': max_core,
            'adj': adj.tolist()
        })

def random_scalefree():
    for _ in range(1000):
        randoms = np.random.random(size=3)
        randoms = randoms / sum(randoms)
        delta_in = 0.2
        delta_out = 0
        G = nx.scale_free_graph(N, randoms[0], randoms[1], randoms[2], delta_in, delta_out)
        adj = nx.to_numpy_array(G)
        adj[np.argwhere(adj > 1)] = 1
        G = nx.Graph(adj)
        G.remove_edges_from(nx.selfloop_edges(G))

        # Stats
        avg_degree = np.sum(adj) / (2 * N)
        std_degree = np.std(sum(adj))
        max_core = get_max_core(G)

        client.network_project.networks.insert_one({
            'type': 'random_scalefree',
            'alpha': randoms[0],
            'beta': randoms[1],
            'gamma': randoms[2],
            'delta_in': delta_in,
            'delta_out': delta_out,
            'N': N,
            'avg_degree': avg_degree,
            'std_degree': std_degree,
            'max_core': max_core,
            'adj': adj.tolist()
        })

def random_bipartite_scalefree():
    for _ in range(1000):
        randoms = np.random.random(size=3)
        randoms = randoms / sum(randoms)
        delta_in = 0.2
        delta_out = 0

        G = nx.scale_free_graph(N, randoms[0], randoms[1], randoms[2], delta_in, delta_out)
        adj = nx.to_numpy_array(G)
        sparse = nx.to_scipy_sparse_matrix(G)
        bipartite = nx.bipartite.from_biadjacency_matrix(sparse)

        adj = nx.to_numpy_array(bipartite)
        adj[np.argwhere(adj > 1)] = 1
        G = nx.Graph(adj)
        G.remove_edges_from(nx.selfloop_edges(G))

        # Stats
        avg_degree = np.sum(adj) / (2 * N)
        std_degree = np.std(sum(adj))
        max_core = get_max_core(G)

        client.network_project.networks.insert_one({
            'type': 'random_bipartite_scalefree',
            'alpha': randoms[0],
            'beta': randoms[1],
            'gamma': randoms[2],
            'delta_in': delta_in,
            'delta_out': delta_out,
            'N': N,
            'avg_degree': avg_degree,
            'std_degree': std_degree,
            'max_core': max_core,
            'adj': adj.tolist()
        })

def solve_for_g_wrapper(x, args):
    mean = solve_for_g(args['N'], args['A'], x, args['d'], 1, 1)
    print(mean)
    return round(mean[0], 2)


random_bipartite_scalefree()
quit()

networks = client.network_project.networks.find({'type': 'random_scalefree', 'max_core': 4, 'solutions': {'$exists': False}})

for network in networks:
    adj = np.array(network['adj'])
    N = int(network['N'])

    death_rate = 0.5
    min_g = death_rate
    iters = 5

    means = []
    for i in range(iters):
        g = min_g + 5*min_g * 0.75 ** i
        mean = solve_for_g(N, adj, g, death_rate, 1, 1, t_end=100)
        means.append([g, mean])

    solution = {'d': death_rate, 'g_vs_mean': means}
    client.network_project.networks.update_one({'_id': network['_id']}, {'$set': {'solutions': [solution]}})
    print('done')