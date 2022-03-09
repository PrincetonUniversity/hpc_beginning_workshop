# Multithreaded MATLAB

Execute these commands to run the example job:

```
$ cd hpc_beginning_workshop/matlab/multithreaded
# edit email address in job.slurm
$ sbatch job.slurm
```

Try different values of `cpus-per-task`. You should find that the code runs about twice as fast when 4 CPU-cores are used versus 2.

For more on MATLAB on the HPC clusters see [this page](https://researchcomputing.princeton.edu/matlab).
