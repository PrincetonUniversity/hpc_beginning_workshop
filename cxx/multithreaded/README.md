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

## Compilation

Compile the program using the following commands:

```
$ ssh <YourNetID>@adroit.princeton.edu
$ wget https://raw.githubusercontent.com/PrincetonUniversity/hpc_beginning_workshop/main/cxx/multithreaded/hello_world_omp.cpp
$ g++ -fopenmp -o hw_omp hello_world_omp.cpp
```

Below is a Slurm script appropriate for an OpenMP job:

```bash
#!/bin/bash
#SBATCH --job-name=cxx_omp       # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=8        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per CPU-core is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send mail if job fails
#SBATCH --mail-user=<YourNetID>@princeton.edu

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module purge

./hw_omp
```

For a simple test code like that above, one could also ignore Slurm and run directly on the login node:

```
$ OMP_NUM_THREADS=8 ./hw_omp
```

## Submit the Job

Submit the job to the cluster:

```
# use a text editor to replace <YourNetID> with your NetID in job.slurm
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

## Intel Compiler

Instead of using GCC, you could compile the program using the Intel compiler:

```
$ module load intel-oneapi/2024.2  # or a module appropriate for your cluster
$ icpx -qopenmp -Ofast -xHost -o hw_omp hello_world_omp.cpp
```

Below is a Slurm script appropriate for an OpenMP job:

```bash
#!/bin/bash
#SBATCH --job-name=cxx_omp       # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=8        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per CPU-core is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send mail if job fails
#SBATCH --mail-user=<YourNetID>@princeton.edu

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module purge
module load intel-oneapi/2024.2

./hw_omp
```

For a simple test code like that above, one could also ignore Slurm and run directly on the login node:

```
$ OMP_NUM_THREADS=8 ./hw_omp
```

## Performance Tips

The example code above is simple and for teaching purposes only. For a real world code, try turning on compiler optimizations and vectorization by adding the flags below.

For Intel:

```
$ icpx -qopenmp -Ofast -xHost -o hw_omp hello_world_omp.cpp
```

For GCC:

```
$ g++ -fopenmp -Ofast -march=native -o hw_omp hello_world_omp.cpp
```

## Learn More

See a list of [learning resources](https://researchcomputing.princeton.edu/education/external-online-resources/openmp) for OpenMP.
