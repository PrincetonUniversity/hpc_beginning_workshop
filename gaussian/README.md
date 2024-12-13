# Gaussian

Read [this page](https://researchcomputing.princeton.edu/gaussian) before trying to use Gaussian on the HPC clusters at Princeton.

After following the directions found on the page above, run the following commands to launch a Gaussian 16 job:

```
$ cd hpc_beginning_workshop/gaussian
# edit email address in job.slurm
$ sbatch job.slurm
```

On Della, include this line in your Slurm script:

```
#SBATCH --constraint=cascade     # avoid the old broadwell CPUs
```

This example job runs for about 25 minutes.
