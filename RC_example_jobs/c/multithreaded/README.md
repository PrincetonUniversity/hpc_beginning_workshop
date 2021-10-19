# Multi-threaded C Program

Here is the source code for a simple multi-threaded C program:

```c
#include <stdio.h>
#include <omp.h>

int main(int argc, char* argv[]) {
 
  #pragma omp parallel
  {
  int id = omp_get_thread_num();
  int nthrds = omp_get_num_threads();
  printf("Hello from thread %d of %d\n", id, nthrds);
  }
  return 0;
}
```

## Compilation

Compile the program using the following commands:

```
$ ssh <YourNetID>@adroit.princeton.edu
$ wget https://raw.githubusercontent.com/PrincetonUniversity/hpc_beginning_workshop/2021fall/RC_example_jobs/c/multithreaded/hello_world_omp.c
$ gcc -fopenmp -o hw_omp hello_world_omp.c
```

Below is a Slurm script appropriate for an OpenMP job:

```bash
#!/bin/bash
#SBATCH --job-name=c_omp         # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=8        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per CPU-core is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --reservation=openmp-workshop  # ONLY VALID DURING LIVE WORKSHOP

module purge
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

./hw_omp
```

Submit the job with:

```
$ sbatch job.slurm
```

For a simple test code like that above, one could also ignore Slurm and run directly on the login node:

```
$ OMP_NUM_THREADS=8 ./hw_omp
```

## Intel OpenMP Workshop (10/19/2021)

Add the line below to your Slurm script to use reserved nodes:

```
#SBATCH --reservation=openmp-workshop  # only valid on 10/19 from 8 AM to 6 PM
```

## Submit the Job

Submit the job to the cluster:

```
# use a text editor to replace <YourNetID> with your NetID in job.slurm
$ sbatch job.slurm
```

The output of the code should resemble the following:

```
Hello from thread 0 of 8
Hello from thread 4 of 8
Hello from thread 6 of 8
Hello from thread 7 of 8
Hello from thread 5 of 8
Hello from thread 2 of 8
Hello from thread 1 of 8
Hello from thread 3 of 8
```

## Intel Compiler

Instead of using GCC, you could compile the program using the Intel compiler:

```
$ module load intel/19.1.1.217  # or a module appropriate for your cluster
$ icc -qopenmp -Ofast -xHost -o hw_omp hello_world_omp.c
```

Below is a Slurm script appropriate for an OpenMP job:

```bash
#!/bin/bash
#SBATCH --job-name=c_omp         # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=8        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per CPU-core is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --reservation=openmp-workshop  # ONLY VALID DURING LIVE WORKSHOP

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module purge
module load intel/19.1.1.217

./hw_omp
```

Submit the job with:

```
$ sbatch job.slurm
```

For a simple test code like that above, one could also ignore Slurm and run directly on the login node:

```
$ OMP_NUM_THREADS=8 ./hw_omp
```

## Performance Tips

The example code above is simple and for teaching purposes only. For a real world code, try turning on compiler optimizations and vectorization by adding the flags below.

For Intel:

```
$ icc -qopenmp -Ofast -xHost -o hw_omp hello_world_omp.c
```

For GCC:

```
$ gcc -fopenmp -Ofast -march=native -o hw_omp hello_world_omp.c
```

## Learn More

See a list of [learning resources](https://researchcomputing.princeton.edu/education/external-online-resources/openmp) for OpenMP.
