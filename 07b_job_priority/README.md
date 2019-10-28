# Job Priority

Here is an explanation from Bill Wichser of Research Computing taken from [here](https://askrc.princeton.edu/question/238/what-determines-my-jobs-priority-under-slurm/):

The Slurm scheduler works much like many other schedulers by simply applying a priority number to a job. To see all jobs with associated priorities one can use

```
squeue -o "%.18i %Q %.9q %.8j %.8u %.10a %.2t %.10M %.10L %.6C %R" | more
```

So how is this number determined?

There are a few factors which determine this value. The command "sprio -w" will show you the current values being used along with the weights associated. Looking at della I find

```
sprio -w

      JOBID   PRIORITY        AGE  FAIRSHARE    JOBSIZE        QOS
    Weights                  1000      10000      10000      10000
```

Let me try to explain what each component tries to do.

AGE - this is an increasing value which increments as a job which is ready to run sits in the queue waiting for resources. It will increment for a maximum time of 10 days which is a configurable limit.

FAIRSHARE this gets complicated but is basically a measure of how much the user and or group has been using the cluster over the past 30 days. See the "sshare -l" command for actual values where the LevelFS is used as a multiplier to either boost or decrement the actual value given past usage.

JOBSIZE - this is basically the number of cores requested such that more cores give higher priority. Why this is important is because wide jobs would be starved if not given a higher priority and smaller jobs can then be backfilled as resources are waiting to be freed.

QOS - use the "qos" command to see the various weights for the quality of service the job is using. This is based almost entirely on the time requested. And in most cases those jobs requesting shorter times are given the highest priority here.

Using the command (all on one line)

```
watch -n 30 -d 'squeue --start --format="%.7i %.7Q %.7q %.15j %.12u %.10a %.20S %.6D %.5C %R" --sort=S --states=PENDING | egrep -v "N/A" | head -20'
```

One can then watch the top jobs waiting to run and begin to see how this works. In many instances you will find lower priority jobs which will run before higher priority ones. This is all due to the requested resources, when they will free, and the decisions the scheduler is making in this regard. This is also why having an accurate representation of timelimit is so important. better fitting of jobs and more accurate scheduling can happen as the actual time specified becomes more accurate for all jobs.

Run the following command to see how many shares your group has as well as your fairshare value: 

```
sshare
```

When running jobs remember to only request what you need.
