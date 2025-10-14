# mpi4py

[MPI for Python](https://mpi4py.readthedocs.io/en/stable/index.html) or `mpi4py` provides a Python interface to MPI. This allows one to run a Python job across multile nodes (the GIL still applies). Please see our [mpi4py guide](https://researchcomputing.princeton.edu/support/knowledge-base/mpi4py) for installations directions and a word of warning.

## Exercise

Follow the webpage above to install `mpi4py`. Explicit directions for Adroit are shown below:

```bash
$ ssh <YourNetID>@adroit.princeton.edu
$ module purge
$ module load anaconda3/2025.6
$ conda create --name fast-mpi4py python=3.8 -y
$ conda activate fast-mpi4py
(fast-mpi4py) $ module load openmpi/gcc/4.1.6
(fast-mpi4py) $ export MPICC=$(which mpicc)
(fast-mpi4py) $ pip install mpi4py --no-cache-dir
```

Now run the example job:

```bash
$ cd /scratch/network/$USER
$ git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
$ cd hpc_beginning_workshop/mpi4py
# use text editor to modify job.slurm with your email address and the Open MPI version (e.g., 4.1.6)
$ sbatch --reservation=bootcamp2 job.slurm
```

If you want to run across 2 nodes (and 64 CPU-cores) then use:

```bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=32
#SBATCH --cpus-per-task=1
```

Then sumbit the job with:

```bash
$ sbatch --reservation=bootcamp2 job.slurm
```

## Challenge

Write a Python code called `send_recv.py` using `mpi4py` with 2 processes where process 0 sends the number 42 to process 1 which prints it out. Write your code based on [these examples](https://mpi4py.readthedocs.io/en/stable/tutorial.html#point-to-point-communication).

Here is an example Slurm script called `job.slurm` (you need to create `send_recv.py`):

```bash
#!/bin/bash
#SBATCH --job-name=mpi4py-ex        # create a name for your job
#SBATCH --nodes=2                   # node count
#SBATCH --ntasks-per-node=1         # number of tasks per node
#SBATCH --cpus-per-task=1           # cpu-cores per task
#SBATCH --mem-per-cpu=1G            # memory per cpu-core
#SBATCH --time=00:01:00             # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail  # receive email notifications

module purge
module load anaconda3/2025.6
module load openmpi/gcc/4.1.6
conda activate fast-mpi4py

srun python send_recv.py
```

Then sumbit the job with:

```bash
$ sbatch --reservation=bootcamp2 job.slurm
```
