# Directions

Follow the directions below to run a parallel C++ code:

```
ssh <YourNetID>@adroit.princeton.edu
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
cd hpc_beginning_workshop/job_examples/python_gpu

module load intel intel-mpi
mpicxx -Wall -o hw_mpi hw_mpi.cpp

sbatch job.slurm
```

The output of the code should be:


