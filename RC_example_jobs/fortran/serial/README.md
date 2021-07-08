# Serial Fortran Program

Follow the directions below to compile and run a serial F90 code. Here
is the source code:

```fortran
program hello_world

write(*,*) 'Hello world'

end program
```

Run the following two commands to compile the code:

```
$ module load intel/19.1/64/19.1.1.217
$ ifort -Ofast -xHost -o hello_world hello_world.f90
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=f90           # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=2G         # memory per cpu-core (4G is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load intel/19.1/64/19.1.1.217

./hello_world
```

To submit the job to the cluster:

```
$ sbatch job.slurm
```

The output of the code should be something like:

```
Hello world
```
