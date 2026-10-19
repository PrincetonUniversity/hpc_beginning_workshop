#!/bin/bash
#SBATCH --job-name=multiray     # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # number of processes
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end    # receive email notifications
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3/2026.7
conda activate <env_with_ray>

srun python ray_example.py
