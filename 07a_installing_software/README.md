# Software

## Using Pre-Install Software with Environment Modules

Lots of software is already available on each cluster. To see the modules that are available run this commond:

```
$ module avail
```

Use the `module load <module name>` command to activate a module. For example:

```
$ julia
-bash: julia: command not found
$ module load julia
$ julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.2.0 (2019-08-20)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```

To compile a parallel code that uses the message-passing interface (MPI) you will need to load an MPI module. You can load the Intel compilers and Intel MPI library with:

```
$ module load intel intel-mpi
$ mpicc --version
icc (ICC) 19.0.3.199 20190206
Copyright (C) 1985-2019 Intel Corporation.  All rights reserved.
```

To see exactly what a module is doing use `module show <module name>`. Modules only change the values of environment variables. They do not install or un-install software. For example:

```
$ module show cudatoolkit
-------------------------------------------------------------------
/usr/local/share/Modules/modulefiles/cudatoolkit/9.2:

module-whatis	 Sets up cudatoolkit92 9.2 in your environment 
prepend-path	 PATH /usr/local/cuda-9.2/bin 
prepend-path	 LD_LIBRARY_PATH /usr/local/cuda-9.2/lib64:/usr/lib64/nvidia 
prepend-path	 LIBRARY_PATH /usr/local/cuda-9.2/lib64:/usr/lib64/nvidia 
prepend-path	 MANPATH /usr/local/cuda-9.2/doc/man 
append-path	 -d   LDFLAGS -L/usr/local/cuda-9.2/lib64 -L/usr/lib64/nvidia 
append-path	 -d   INCLUDE -I/usr/local/cuda-9.2/include 
append-path	 CPATH /usr/local/cuda-9.2/include 
append-path	 -d   FFLAGS -I/usr/local/cuda-9.2/include 
append-path	 -d   LOCAL_LDFLAGS -L/usr/local/cuda-9.2/lib64 -L/usr/lib64/nvidia 
append-path	 -d   LOCAL_INCLUDE -I/usr/local/cuda-9.2/include 
append-path	 -d   LOCAL_CFLAGS -I/usr/local/cuda-9.2/include 
append-path	 -d   LOCAL_FFLAGS -I/usr/local/cuda-9.2/include 
append-path	 -d   LOCAL_CXXFLAGS -I/usr/local/cuda-9.2/include 
-------------------------------------------------------------------
```

If you need software that is not install, your will mostly likely have to do it yourself.

## A Word on Python

When you first log in to the cluster, the system Python is used by default:

```
$ python --version
Python 2.7.5

$ which python
/usr/bin/python
```

To load Anaconda Python you must load the module:

```
$ module load anaconda3
$ python --version
Python 3.7.3
$ which python
/usr/licensed/anaconda3/2019.3/bin/python
```

To see all the packages that are included in Anaconda Python run this command:

```
$ conda list
```

## A Word on R

To start R and then immediately exit:

```
$ R
> q()
```

Note that RStudio is available through the [MyAdroit](https://myadroit.princeton.edu) web portal.

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
