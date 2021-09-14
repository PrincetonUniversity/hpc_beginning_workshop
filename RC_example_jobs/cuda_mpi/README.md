# CUDA-Aware MPI

This example is based on the tutorial here: <https://www.olcf.ornl.gov/tutorials/gpudirect-mpich-enabled-cuda>.

### Adroit (GPU)

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load intel/19.1/64/19.1.1.217 cudatoolkit/10.2 openmpi/cuda-10.2/intel-19.1
$ mpicc -lcudart direct.c -o direct.out
$ sbatch job.slurm
```

### Della-GPU

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load nvhpc/21.5 cudatoolkit/11.3 openmpi/cuda-11.3/nvhpc-21.5/4.1.1
$ mpicc -lcudart direct.c -o direct.out
$ sbatch job.slurm  # be sure to load the correct modules in job.slurm
```

Or to use GCC:

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load cudatoolkit/11.1 openmpi/cuda-11.1/gcc/4.1.1
$ mpicc -lcudart direct.c -o direct.out
$ sbatch job.slurm  # be sure to load the correct modules in job.slurm
```

### Traverse

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load cudatoolkit/11.0 openmpi/cuda-11.0/gcc/4.0.4/64 
$ mpicc -lcudart direct.c -o direct.out
$ sbatch job.slurm  # be sure to load the correct modules in job.slurm
```

Or using nvhpc:

```
$ cd hpc_beginning_workshop/RC_example_jobs/cuda_mpi
$ module load nvhpc/20.7 cudatoolkit/11.0 openmpi/cuda-11.0/nvhpc-20.7/4.0.4/64
$ mpicc -L/usr/local/cuda-11.0/targets/ppc64le-linux/lib -lcudart direct.c -o direct.out
$ sbatch job.slurm  # be sure to load the correct modules in job.slurm
```
