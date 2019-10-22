# Multi-threaded C++ Program

Here is the source code for a simple multi-threaded C++ program:

```c++
#include <iostream>
#include <omp.h>

int main(int argc, char* argv[]) {
  using namespace std;
 
  #pragma omp parallel
  {
  int id = omp_get_thread_num();
  int nthrds = omp_get_num_threads();
  cout << "Hello from thread " << id << " of " << nthrds << endl;
  }
  return 0;
}
```

Compile the program using the following commands:

```
module load intel
icpc -qopenmp -o hello_world_omp hello_world_omp.cpp
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=cxx_omp       # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks-per-node=1      # total number of tasks across all nodes
#SBATCH --cpus-per-task=8        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module load intel
srun ./hello_world_omp
```

Submit the job to the cluster:

```
$ sbatch job.slurm
```

The output of the code should resemble the following:

```
Hello from thread Hello from thread Hello from thread Hello from thread Hello from thread Hello from thread 3 of 826 of 0584 of 8
Hello from thread 

 of  of 8
7 of 8
 of 8
Hello from thread 1 of 8
8
```
