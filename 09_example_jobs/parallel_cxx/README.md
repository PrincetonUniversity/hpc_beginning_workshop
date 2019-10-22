# Parallel C++ Program

Follow the directions below to compile and run a parallel C++ code. Here
is the source code:

```c++
#include <iostream>
#include <mpi.h>

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

  // Print off a hello world message
  cout << "Process " << world_rank << " of " << world_size
       << " says hello from " << processor_name << endl;

  MPI_Finalize();
  return 0;
}
```

Run the following two commands to compile the code:

```
module load intel intel-mpi
mpicxx -Wall -o hello_world_mpi hello_world_mpi.cpp
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=cxx_mpi       # create a short name for your job
#SBATCH --nodes=2                # node count
#SBATCH --ntasks=32              # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load intel intel-mpi

srun ./hello_world_mpi
```

To submit the job to the cluster:

```
$ sbatch job.slurm
```

The output of the code should be something like:

```
Process 17 of 32 says hello from adroit-03
Process 1 of 32 says hello from adroit-02
Process 4 of 32 says hello from adroit-02
Process 5 of 32 says hello from adroit-02
Process 6 of 32 says hello from adroit-02
Process 7 of 32 says hello from adroit-02
Process 8 of 32 says hello from adroit-02
Process 9 of 32 says hello from adroit-02
Process 12 of 32 says hello from adroit-02
Process 14 of 32 says hello from adroit-02
Process 0 of 32 says hello from adroit-02
Process 2 of 32 says hello from adroit-02
Process 18 of 32 says hello from adroit-03
Process 3 of 32 says hello from adroit-02
Process 19 of 32 says hello from adroit-03
Process 10 of 32 says hello from adroit-02
Process 21 of 32 says hello from adroit-03
Process 11 of 32 says hello from adroit-02
Process 22 of 32 says hello from adroit-03
Process 13 of 32 says hello from adroit-02
Process 23 of 32 says hello from adroit-03
Process 15 of 32 says hello from adroit-02
Process 24 of 32 says hello from adroit-03
Process 25 of 32 says hello from adroit-03
Process 26 of 32 says hello from adroit-03
Process 27 of 32 says hello from adroit-03
Process 28 of 32 says hello from adroit-03
Process 29 of 32 says hello from adroit-03
Process 30 of 32 says hello from adroit-03
Process 31 of 32 says hello from adroit-03
Process 16 of 32 says hello from adroit-03
Process 20 of 32 says hello from adroit-03
```
