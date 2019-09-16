# Directions

Follow the directions below to run a simple Julia script on the Princeton HPC clusters:

```
ssh <YourNetID>@adroit.princeton.edu
git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
cd hpc_beginning_workshop/job_examples/serial_julia

module purge
module load julia

sbatch job.slurm
```

The script prints out "Hello, world."
