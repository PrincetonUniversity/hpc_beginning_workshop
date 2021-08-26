# Parallel Fortran Program

Follow the directions below to compile and run a parallel F90 code. Here
is the source code:

```fortran
program hello_world_mpi

include 'mpif.h'
integer*4 rank, size, ierror, tag, status(MPI_STATUS_SIZE)

call MPI_INIT(ierror)
call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)
call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)
write(*,*) 'node', rank, ': Hello world'
call MPI_FINALIZE(ierror)

end program
```

Run the following two commands to compile the code:

```
$ module load intel intel-mpi
$ mpif90 -O3 -o hello_world_mpi hello_world_mpi.f90
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=f90-mpi       # create a short name for your job
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
 node           0 : Hello world
 node          16 : Hello world
 node           1 : Hello world
 node           2 : Hello world
 node           3 : Hello world
 node           4 : Hello world
 node           5 : Hello world
 node           6 : Hello world
 node           7 : Hello world
 node           8 : Hello world
 node           9 : Hello world
 node          10 : Hello world
 node          11 : Hello world
 node          12 : Hello world
 node          13 : Hello world
 node          14 : Hello world
 node          15 : Hello world
 node          18 : Hello world
 node          23 : Hello world
 node          27 : Hello world
 node          28 : Hello world
 node          30 : Hello world
 node          31 : Hello world
 node          17 : Hello world
 node          19 : Hello world
 node          20 : Hello world
 node          21 : Hello world
 node          22 : Hello world
 node          24 : Hello world
 node          26 : Hello world
 node          29 : Hello world
 node          25 : Hello world
```
