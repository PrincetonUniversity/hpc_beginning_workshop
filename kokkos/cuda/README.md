# Kokkos with CUDA Back-end

```
$ git clone https://github.com/kokkos/kokkos.git
$ module load cudatoolkit/11.6
$ cd kokkos && mkdir build
$ cmake -DCMAKE_CXX_COMPILER=$HOME/software/kokkos/bin/nvcc_wrapper -DCMAKE_INSTALL_PREFIX=$HOME/.local -DKokkos_ENABLE_CUDA=On -DKokkos_ARCH_AMPERE80=On -DKokkos_CUDA_DIR=$CUDA_HOME -DKokkos_CXX_STANDARD=17 ..
$ make
$ make install

$ g++ -I$HOME/.local/include -L$HOME/.local/lib64 -o hello_world hello_world.cpp -lkokkoscore
```
