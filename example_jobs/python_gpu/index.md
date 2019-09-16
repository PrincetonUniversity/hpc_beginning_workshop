# Directions

Follow the directions below to use the Python CuPy module on a GPU:

```
ssh <YourNetID>@adroit.princeton.edu
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
cd hpc_beginning_workshop/job_examples/python_gpu

module load anaconda3
conda create --name py-gpu cupy
sbatch job.slurm
```

The code computes the singular value decomposition of a random 10x10 matrix.
