# Directions

Follow the directions below to compile and run a simple C code on the Princeton HPC clusters:

```
ssh <YourNetID>@adroit.princeton.edu
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
cd hpc_beginning_workshop/job_examples/serial_c

module load intel
icc -O2 -o hello_world hello_world.c
sbatch job.slurm
```

The code prints out "Hello, world."
