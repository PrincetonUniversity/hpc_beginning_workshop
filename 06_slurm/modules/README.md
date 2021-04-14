# Modules

[Table of Contents](/hpc_beginning_workshop/)


**NOTE: This brief explanation assumes you understand how SLURM works, if you
don't go back to the [introduction to Slurm](../)**

Enterprise Linux configurations like those used on Adroit often have very
out of date system packages. This provides great stability, but is often not
useful for development and data science.

The way around this is the `module` system.

## Listing modules

Modules work by setting various environment variables, especially your `$PATH`,
to point to the appropriate, more up to date installations provided as part
of the software on the cluster.

To load a module on the head node, just type:

```
module load <name of module/version>
```
i.e.

```
module load anaconda3/2020.11
```

You can see installed modules using `module avail`
(`module avail <keyword>` to search for a phrase).

## Using modules

For example, when you `module load anaconda3/2020.11`, you will load the `Anaconda`
distribution of Python3, which comes preloaded with data science libraries
and its own virtual environment manager.

## Getting rid of modules

You can unload all modules by simply relogging into the cluster, or more easily
via `module purge`. To unload a specific module, `module unload <name>`.

## Don't put these in .bashrc

You may be tempted to put these in `.bashrc`. Don't. By all means set up an alias
for your use, but `.bashrc` is not implicitly loaded for a SLURM job. You're
likely to set up a situation where you have tangled modules and not quite sure
why your job is failing to behave as expected.
