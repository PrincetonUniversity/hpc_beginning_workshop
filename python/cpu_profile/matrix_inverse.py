import numpy as np

@profile
def main():
    N = 2500
    X = np.random.randn(N, N)
    print("X =\n", X)
    print("Inverse(X) =\n", np.linalg.inv(X))

if __name__ == "__main__":
    main()

