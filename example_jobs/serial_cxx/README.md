# Directions

Follow the directions below to compile and run a simple C++ program on the Princeton HPC clusters:

```
ssh <YourNetID>@adroit.princeton.edu
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
cd hpc_beginning_workshop/job_examples/serial_cxx

module load intel
icpc -Wall -o hello_world hello_world.cpp

sbatch job.slurm
```

The program prints out "Hello, world."
