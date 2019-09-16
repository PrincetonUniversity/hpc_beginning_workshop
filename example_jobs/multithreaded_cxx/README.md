# Directions

Follow the directions below to run a parallel C++ code:

```
ssh <YourNetID>@adroit.princeton.edu
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
cd hpc_beginning_workshop/job_examples/multithreading_cxx

module load intel
icpc -Wall -qopenmp -o hw_omp hw_omp.cpp

sbatch job.slurm
```

The output of the code should be:


