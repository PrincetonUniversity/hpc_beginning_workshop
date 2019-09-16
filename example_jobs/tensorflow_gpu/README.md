# Directions

Follow the directions below to run TensorFlow on Adroit:

```
ssh <YourNetID>@adroit.princeton.edu
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
cd hpc_beginning_workshop/job_examples/tensorflow_gpu

module load anaconda3
conda create --name tf-gpu tensorflow-gpu
conda activate tf-gpu

sbatch job.slurm
```

A complete guide to getting started with TensorFlow is here:
[https://github.com/PrincetonUniversity/slurm_mnist](https://github.com/PrincetonUniversity/slurm_mnist)
