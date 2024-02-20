#!/bin/bash
#SBATCH --job-name=mpi4py-test   # create a name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=4               # total number of tasks
#SBATCH --cpus-per-task=1        # cpu-cores per task
#SBATCH --mem-per-cpu=1G         # memory per cpu-core
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3/2022.5 openmpi/gcc/<x.y.z>  # REPLACE <x.y.z>
conda activate fast-mpi4py

srun python hello_mpi.py
