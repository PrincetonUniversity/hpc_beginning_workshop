# mpi4py

Please see our [mpi4py guide](https://researchcomputing.princeton.edu/support/knowledge-base/mpi4py).

## Exercise

Follow the webpage above to install `mpi4py` and then return here to run the code:

```
$ git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
$ cd hpc_beginning_workshop/mpi4py
# use text editor to modify job.slurm with your email address
$ sbatch job.slurm
```

Did you encounter `mca_base_component_repository_open: unable to open mca_op_avx`? This is a [known issue](https://github.com/open-mpi/ompi/issues/8323) with Open MPI 4.1.0.

## Challenge

Write a Python code using `mpi4py` using 2 processes where process 0 sends the number "42" to process 1 which prints it out. Write your code based on [these examples](https://mpi4py.readthedocs.io/en/stable/tutorial.html#point-to-point-communication).
