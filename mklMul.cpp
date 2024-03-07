#include "bural.h"
#include <iostream>
#include <chrono>
#include <Eigen/Dense>
#include <armadillo>
#include "Matrix.hpp"
#include "BasicStrategy.hpp"
#include "EigenSumStrategy.hpp" 
#include "mtx_io.hpp"
#include <iostream>
#include <memory>
#include <string>
#include "mkl.h"

// Declare a função de multiplicação de matrizes contida na sua biblioteca
//extern "C" void multMatrizes(double* matriz1, double* matriz2, double* resultado, int N);

void multiplyMatrices(double* A, double* B, double* C, int N) {
    double alpha = 1.0, beta = 0.0;
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, 
                N, N, N, alpha, A, N, B, N, beta, C, N);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cout << "Uso: " << argv[0] << " <tamanho da matriz>" << std::endl;
        return 1;
    }

    int N = atoi(argv[1]);

    std::cout << "Iniciando ......." << std::endl;

    double *mat1_ptr, *iden_ptr, *resultado_ptr;
    
    // Alocação de memória para as matrizes A, B e C
    mat1_ptr = new double[N*N];
    iden_ptr = new double[N*N];
    resultado_ptr = new double[N*N];

    // Preenchendo A com 2s e B com a matriz identidade
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            mat1_ptr[i*N + j] = 2.0;
            iden_ptr[i*N + j] = (i == j) ? 1.0 : 0.0;
        }
    }

    auto start_custom_mkl = std::chrono::high_resolution_clock::now();
    // Chamada à função multiplyMatrices usando MKL
    multiplyMatrices(mat1_ptr, iden_ptr, resultado_ptr, N);
    auto end_custom_mkl = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> diff_custom_mkl = end_custom_mkl - start_custom_mkl;
    std::cout << "MKL levou: " << diff_custom_mkl.count() << " segundos." << std::endl;

    // Liberar a memória alocada
    delete[] mat1_ptr;
    delete[] iden_ptr;
    delete[] resultado_ptr;

    return 0;
}
