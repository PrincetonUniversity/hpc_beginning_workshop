from mpi4py import MPI

if __name__ == "__main__":

    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()

    if rank == 0:
        data = 42
        comm.send(data, dest=1, tag=12345)
    elif rank == 1:
        data = comm.recv(source=0, tag=12345)
        print(f"Process 1 received the value {data}")
