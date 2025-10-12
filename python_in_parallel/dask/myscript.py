import random, time

import dask
import pandas as pd
import numpy as np

def costly_simulation(list_param):
    time.sleep(random.random())
    return sum(list_param)

input_params = pd.DataFrame(np.random.random(size=(500, 4)), columns=['param_a', 'param_b', 'param_c', 'param_d'])

lazy_results = []

for parameters in input_params.values[:10]:
    lazy_result = dask.delayed(costly_simulation)(parameters)
    lazy_results.append(lazy_result)

print(dask.compute(*lazy_results))
