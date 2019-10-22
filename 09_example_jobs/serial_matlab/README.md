# Serial Matlab Script

Here is a trivial one-line Matlab script (`hello_world.m`):

```
fprintf('Hello world.\n')
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=matlab        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multithread tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send mail when process begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH -p hpc                   # DELETE THIS LINE AFTER WORKSHOP

module purge
module load matlab
module list

srun matlab -singleCompThread -nodisplay -nosplash -nojvm -r hello_world
```

To run the Matlab script, simply submit the job to the cluster with the following command:

```
$ sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
...
Hello world.
```

Use `squeue -u $USER` to monitor queued jobs. For more on submitting Matlab jobs see [this post](https://oncomputingwell.princeton.edu/2017/03/your-first-slurm-script-to-run-matlab/).
