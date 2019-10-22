# Serial Julia Script

Here is a simple Julia script:

```
println("Hello, world.")
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=serial_jl     # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load julia

srun julia hello_world.jl
```

To run the Julia script, simply submit the job to the cluster:

```
$ sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
Hello, world.
```

Use `squeue -u $USER` to monitor queued jobs.
