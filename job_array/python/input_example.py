import os
idx = int(os.environ["SLURM_ARRAY_TASK_ID"])

with open(f'{idx}.in', 'r') as f:
    lines = f.readlines()

my_list = [int(a) for a in lines[0].strip().split(',')]

print([a**3 for a in my_list])
