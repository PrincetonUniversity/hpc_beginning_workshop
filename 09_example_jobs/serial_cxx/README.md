# Serial C++ Program

Follow the directions below to compile and run a simple C++ program on the Princeton HPC clusters.
Here is the source code:

```c++
#include <iostream>

int main(int argc, char* argv[]) {
  std::cout << "Hello, world." << std::endl;
  return 0;
}
```

Compile the program with:

```
module load intel
icpc -o hello_world hello_world.cpp
```

Here is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=cxx_serial    # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load intel

srun ./hello_world
```

To submit the job to the cluster:

```
$ sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
Hello, world.
```

Use `squeue -u $USER` to monitor queued jobs.
