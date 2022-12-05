import numpy as np
from scipy.integrate import odeint
from scipy.optimize import fixed_point

def f(i, xs, A, G, d, s, a):
    N = len(A)
    result = -d*xs[i] - s*xs[i]**2

    for j in range(N):
        inner_sum = a
        for k in range(N):
            inner_sum += A[i, k] * xs[k]
        inner_sum = A[i, j] * G[i, j] * (xs[i] * xs[j]) / inner_sum
        result += inner_sum

    return result

def f_wrapper()

N = 10
xs = np.arange(1, N + 1, 1)
A = np.random.randint(0, 2, size=(N, N))
G = np.random.random(size=(N, N))
x = f(0, xs, A, G, 1, 1, 1)

print()