#!/bin/bash
#SBATCH --job-name=matlab-svd       # create a short name for your job
#SBATCH --nodes=1                   # node count
#SBATCH --ntasks=1                  # total number of tasks across all nodes
#SBATCH --cpus-per-task=1           # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G            # memory per cpu-core (4G is default)
#SBATCH --time=00:02:00             # total run time limit (HH:MM:SS)
#SBATCH --gres=gpu:1                # number of gpus per node
#SBATCH --mail-type=begin,end,fail  # receive email notifications
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load matlab/R2024a

matlab -singleCompThread -nodisplay -nosplash -r svd
