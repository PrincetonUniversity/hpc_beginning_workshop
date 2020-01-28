# Hybrid MPI/OpenMP C++ Program

Follow the directions below to compile and run this C++ code which uses MPI and OpenMP. Here
is the source code:

```c++
#include <iostream>
#include <mpi.h>
#include <omp.h>

int main(int argc, char** argv) {
  using namespace std;
  
  MPI_Init(&argc, &argv);

  int world_size, world_rank;
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

  // Get the name of the processor
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;
  MPI_Get_processor_name(processor_name, &name_len);

  #pragma omp parallel
  {
  int id = omp_get_thread_num();
  int nthrds = omp_get_num_threads();
  cout << "Hello from thread " << id << " of " << nthrds
       << " on MPI process " << world_rank << " of " << world_size
       << " on node " << processor_name << endl;
  }

  MPI_Finalize();
  return 0;
}
```

Run the following two commands to compile the code:

```
$ module load intel intel-mpi
$ mpicxx -qopenmp -o mpi_openmp_hello_world mpi_openmp_hello_world.cpp
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=cxx_mpi_omp   # create a short name for your job
#SBATCH --nodes=3                # node count
#SBATCH --ntasks-per-node=2      # total number of tasks per node
#SBATCH --cpus-per-task=5        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module purge
module load intel intel-mpi

srun ./mpi_openmp_hello_world
```

To submit the job to the cluster:

```
$ sbatch job.slurm
```

The output of the code should be a messy version of that below:

```
Hello from thread 0 of 5 on MPI process 0 of 6 on node traverse-k02g4
Hello from thread 1 of 5 on MPI process 0 of 6 on node traverse-k02g4
Hello from thread 2 of 5 on MPI process 0 of 6 on node traverse-k02g4
Hello from thread 3 of 5 on MPI process 0 of 6 on node traverse-k02g4
Hello from thread 4 of 5 on MPI process 0 of 6 on node traverse-k02g4
Hello from thread 0 of 5 on MPI process 1 of 6 on node traverse-k02g4
Hello from thread 1 of 5 on MPI process 1 of 6 on node traverse-k02g4
Hello from thread 2 of 5 on MPI process 1 of 6 on node traverse-k02g4
Hello from thread 3 of 5 on MPI process 1 of 6 on node traverse-k02g4
Hello from thread 4 of 5 on MPI process 1 of 6 on node traverse-k02g4

Hello from thread 0 of 5 on MPI process 2 of 6 on node traverse-k02g5
Hello from thread 1 of 5 on MPI process 2 of 6 on node traverse-k02g5
Hello from thread 2 of 5 on MPI process 2 of 6 on node traverse-k02g5
Hello from thread 3 of 5 on MPI process 2 of 6 on node traverse-k02g5
Hello from thread 4 of 5 on MPI process 2 of 6 on node traverse-k02g5
Hello from thread 0 of 5 on MPI process 3 of 6 on node traverse-k02g5
Hello from thread 1 of 5 on MPI process 3 of 6 on node traverse-k02g5
Hello from thread 2 of 5 on MPI process 3 of 6 on node traverse-k02g5
Hello from thread 3 of 5 on MPI process 3 of 6 on node traverse-k02g5
Hello from thread 4 of 5 on MPI process 3 of 6 on node traverse-k02g5

Hello from thread 0 of 5 on MPI process 4 of 6 on node traverse-k02g6
Hello from thread 1 of 5 on MPI process 4 of 6 on node traverse-k02g6
Hello from thread 2 of 5 on MPI process 4 of 6 on node traverse-k02g6
Hello from thread 3 of 5 on MPI process 4 of 6 on node traverse-k02g6
Hello from thread 4 of 5 on MPI process 4 of 6 on node traverse-k02g6
Hello from thread 0 of 5 on MPI process 5 of 6 on node traverse-k02g6
Hello from thread 1 of 5 on MPI process 5 of 6 on node traverse-k02g6
Hello from thread 2 of 5 on MPI process 5 of 6 on node traverse-k02g6
Hello from thread 3 of 5 on MPI process 5 of 6 on node traverse-k02g6
Hello from thread 4 of 5 on MPI process 5 of 6 on node traverse-k02g6
```
