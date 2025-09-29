# Serial C Program

Follow the directions below to compile and run a simple C program on the Princeton Research Computing clusters.
Here is the source code:

```c
#include <stdio.h>

int main() {
  printf("Hello, world.\n");
  return 0;
}
```

Compile the program with:

```
$ module load intel-oneapi/2024.2
$ icx -o hello_world hello_world.c
```

Here is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=serial_c      # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end    # send email when job begins
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load intel-oneapi/2024.2

./hello_world
```

To submit the job to the cluster by running the following command:

```
$ sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
Hello, world.
```

Use `squeue --me` to monitor queued jobs.
