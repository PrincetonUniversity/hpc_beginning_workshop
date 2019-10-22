# Installing Software

Lots of software is already available on each cluster. To see the modules that are available run this commond:

```
$ module avail
```

Use the `module load <module-name>` command to activate a module.

If you need software that is not install, your will mostly likely have to do it yourself.

## Where to install software

We recommend that your create a directory such as `/home/<YourNetID>/software` to store and build software. Your home directory is backed-up. Be sure to run the `checkquota` command regularly to make sure you have enough space.

## Installing Python Packages on the HPC Clusters

See [this guide](https://github.com/PrincetonUniversity/installing_python_packages) for installing Python packages.

## Installing R Packages on the HPC Clusters

Most packages you should be 
able to install as is, with no special modules. Some modules require a 
newer version of C++ compiler and therefore require

```
module load rh
```

for a newer gcc/g++.  Some require a newer gsl

```
module load gsl
```

(if you require gsl you will need to load the same module also for jobs, 
rh does not need to be loaded in jobs).  Also, any R module installs 
have to be performed on the login node.
