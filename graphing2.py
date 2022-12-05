import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data = pd.read_csv('graph_data.csv', delimiter=',')
logic = pd.DataFrame({
    'x': [1.55, 1.90, 2.00, 2.90, 3.00, 4.00, 4.00],
    'y': [0.60, 0.54, 0.45, 0.39, 0.28, 0.21, 0.00]
})

plt.title('K vs <s*> Andes Pollenators')
plt.xlabel('K')
plt.ylabel('<s*>')
plt.plot(data['x'], data['y'])
plt.plot(logic['x'], logic['y'], c='k')
plt.xlim(0, 5)
plt.ylim(0, 0.6)
plt.show(block=True)