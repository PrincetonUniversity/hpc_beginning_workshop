import ray
ray.init()  # or ray.init(address="auto") on a cluster

@ray.remote
def f(x):
    return x * x

futures = [f.remote(i) for i in range(4)]
print(ray.get(futures))