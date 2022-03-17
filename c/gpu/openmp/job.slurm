#!/bin/bash
#SBATCH --job-name=c_omp         # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=8        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per CPU-core is default)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --time=00:00:10          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

./hw_omp_gpu
