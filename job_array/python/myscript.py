import os
idx = int(os.environ["SLURM_ARRAY_TASK_ID"])
parameters = [0, 10, 20]
myparam = parameters[idx]
print(f"INFO: Job with array task id {idx} is using myparam={myparam}")
with open(f"output_taskid_{idx}_myparam_{myparam}.out", "w") as f:
    msg = f"Output file for task id {idx} using myparam={myparam}\n"
    f.write(msg)
