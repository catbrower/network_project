class RK4(object):
    def __init__(self, *functions):
        self.f = functions
        self.t = 0

    def solve(self, y, h, n):
        t = []
        res = []
        for i in y:
            res.append([])

        while self.t <= n and h != 0:
            t.append(self.t)
            y = self._solve(y, self.t, h)
            for c, i in enumerate(y):
                res[c].append(i)

            self.t += h

            if self.t + h > n:
                h = n - self.t

        return t, res


    def _solve(self, y, t, h):
        k1 = []
        k2 = []
        k3 = []
        k4 = []
        for f in self.f:
            k1.append(h * f(t, *y))
            k2.append(h * f(t + .5*h, *[y[i] + .5*h*k1[i] for i in range(0, len(y))]))
            k3.append(h * f(t + .5*h, *[y[i] + .5*h*k2[i] for i in range(0, len(y))]))
            k4.append(h * f(t + h, *[y[i] + h*k3[i] for i in range(0, len(y))]))

        return [y[i] + (k1[i] + 2*k2[i] + 2*k3[i] + k4[i]) / 6.0 for i in range(0, len(y))]