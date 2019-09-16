import cupy as cp

X = cp.random.randn(10, 10)
u, s, v = cp.linalg.decomposition.svd(X)
print(s)
