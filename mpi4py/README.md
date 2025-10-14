# mpi4py

Please see our [mpi4py guide](https://researchcomputing.princeton.edu/support/knowledge-base/mpi4py).

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
$ sbatch job.slurm
```

If you want to run across 2 nodes (and 64 CPU-cores) then use:

```
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=32
#SBATCH --cpus-per-task=1
```

Then sumbit the job with:

```
$ sbatch job.slurm
```


Did you encounter `mca_base_component_repository_open: unable to open mca_op_avx`? This is a [known issue](https://github.com/open-mpi/ompi/issues/8323) with Open MPI 4.1.6.

## Challenge

Write a Python code using `mpi4py` using 2 processes where process 0 sends the number 42 to process 1 which prints it out. Write your code based on [these examples](https://mpi4py.readthedocs.io/en/stable/tutorial.html#point-to-point-communication).
