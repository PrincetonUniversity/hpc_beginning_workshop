# hello_mpi.py:
# usage: python hello_mpi.py

from mpi4py import MPI

def print_hello(rank, size, name):
    msg = f"Hello World! I am process {rank} of {size} on {name}."
    print(msg)

if __name__ == "__main__":
    size = MPI.COMM_WORLD.Get_size()
    rank = MPI.COMM_WORLD.Get_rank()
    name = MPI.Get_processor_name()

    print_hello(rank, size, name)
