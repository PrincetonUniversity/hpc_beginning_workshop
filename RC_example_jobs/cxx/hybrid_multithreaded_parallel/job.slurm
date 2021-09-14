#!/bin/bash
#SBATCH --job-name=cxx_mpi_omp   # create a short name for your job
#SBATCH --nodes=3                # node count
#SBATCH --ntasks-per-node=2      # number of tasks per node
#SBATCH --cpus-per-task=5        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send mail if job fails
#SBATCH --mail-user=<YourNetID>@princeton.edu

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module purge
module load intel/19.1/64/19.1.1.217 intel-mpi/intel/2019.7/64

srun ./mpi_openmp_hello_world
