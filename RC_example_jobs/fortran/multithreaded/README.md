# Multi-threaded Fortran Program

Here is the source code for a simple multi-threaded C++ program:

```fortran
program hello_world_multithreaded
use omp_lib

!$omp parallel

    write(*,*) "Hello from process ", omp_get_thread_num(), " of ", omp_get_num_threads()

!$omp end parallel

end program
```

Compile the program using the following commands:

```
$ module load intel/19.1/64/19.1.1.217  # or a module appropriate for your cluster
$ ifort -qopenmp -Ofast -xHost -o hw_omp hello_world_omp.f90
```

Below is a Slurm script appropriate for an OpenMP job:

```bash
#!/bin/bash
#SBATCH --job-name=fortran_omp   # create a short name for your job
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
module load intel/19.1/64/19.1.1.217

./hw_omp
```

Submit the job to the cluster:

```
$ sbatch job.slurm
```

The output of the code should resemble the following:

```
 Hello from process            3  of            8
 Hello from process            5  of            8
 Hello from process            6  of            8
 Hello from process            7  of            8
 Hello from process            4  of            8
 Hello from process            0  of            8
 Hello from process            2  of            8
 Hello from process            1  of            8
```
