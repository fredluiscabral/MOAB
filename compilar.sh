g++ -std=c++11 -O3 -I/usr/include/eigen3 -I/prj/prjad/fcabral/Doutorado/MOAB -I/opt/intel/oneapi/mkl/2024.0/include /prj/prjad/fcabral/Doutorado/MOAB/bural.c laicoMult.cpp -L/opt/intel/oneapi/mkl/2024.0/lib/intel64 -Wl,-rpath,/opt/intel/oneapi/mkl/2024.0/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl -fopenmp -march=native -fopt-info-vec -ffast-math -ftree-vectorize -DARMA_DONT_USE_WRAPPER -o laicoMult

