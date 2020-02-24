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
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email when job fails
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load matlab

matlab -singleCompThread -nodisplay -nosplash -r hello_world
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

Use `squeue -u $USER` to monitor queued jobs. For more on submitting Matlab jobs see [this guide](https://github.com/PrincetonUniversity/running_matlab).
