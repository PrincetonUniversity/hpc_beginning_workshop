# hello_mpi.py:
# usage: python hello_mpi.py

from mpi4py import MPI
import sys

def print_hello(rank, size, name):
  msg = "Hello World! I am process {0} of {1} on {2}.\n"
  sys.stdout.write(msg.format(rank, size, name))

if __name__ == "__main__":
  size = MPI.COMM_WORLD.Get_size()
  rank = MPI.COMM_WORLD.Get_rank()
  name = MPI.Get_processor_name()

  print_hello(rank, size, name)
