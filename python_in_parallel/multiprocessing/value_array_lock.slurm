#!/bin/bash
#SBATCH --job-name=multival      # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # number of processes
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end    # receive email notifications
#SBATCH --mail-user=<netid>@princeton.edu

module purge
module load anaconda3/2025.6

srun python value_array_lock.py