g++ -std=c++11 -O3 -I/home/fcabral/eigen-3.4.0 -I/home/fcabral/Tese/MOAB -I/opt/intel/oneapi/mkl/latest/include /home/fcabral/Tese/MOAB/bural.c laicoMult.cpp -L/opt/intel/oneapi/mkl/latest/lib/intel64 -Wl,-rpath,/opt/intel/oneapi/mkl/latest/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl -fopenmp -march=native -fopt-info-vec -ffast-math -ftree-vectorize -DARMA_DONT_USE_WRAPPER -o laicoMult
