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

    // Alocação de memória para as matrizes A, B e C
    double *mat1_ptr, *iden_ptr, *resultado_ptr;
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



    // Criar as matrizes usando Eigen e Armadillo
    Eigen::MatrixXd mat1 = Eigen::MatrixXd::Constant(N, N, 2.0);
    Eigen::MatrixXd iden = Eigen::MatrixXd::Identity(N, N);

    arma::mat A = arma::ones<arma::mat>(N, N) * 2.0;
    arma::mat I = arma::eye<arma::mat>(N, N);

    // Multiplicar matrizes usando sua função

    alocarMatrizes(&mat1_ptr, &iden_ptr, &resultado_ptr, N);
    preencherMatrizes(mat1_ptr, iden_ptr, N);

    auto start_custom = std::chrono::high_resolution_clock::now();
    multMatrizes(mat1_ptr, iden_ptr, resultado_ptr, N); // Chame sua função
    auto end_custom = std::chrono::high_resolution_clock::now();

    // Verificar o resultado opcionalmente
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            if (mat1_ptr[i*N + j] != 2.0) {
                std::cout << "Erro no resultado da matriz customizada ..." << resultado_ptr[i*N + j] << " " << i << " " << j << std::endl;
                delete[] resultado_ptr;
                return -1;
            }
        }
    }

    std::chrono::duration<double> diff_custom = end_custom - start_custom;
    std::cout << "Bural levou: " << diff_custom.count() << " segundos." << std::endl;

    // Limpar memória alocada dinamicamente
    delete[] resultado_ptr;

    // Multiplicar matrizes usando Eigen e Armadillo
    auto start_eigen = std::chrono::high_resolution_clock::now();
    Eigen::MatrixXd result_eigen = mat1 * iden;
    auto stop_eigen = std::chrono::high_resolution_clock::now();

    arma::mat result_armadillo = A * I;
    auto end_armadillo = std::chrono::high_resolution_clock::now();

    // Verificar o resultado opcionalmente
    for (int i = 0; i < result_eigen.rows(); ++i) {
        for (int j = 0; j < result_eigen.cols(); ++j) {
            if (result_eigen(i, j) != 2.0) {
                std::cout << "Erro no resultado Eigen ..." << std::endl;
                return -1;
            }
        }
    }

    for (int i = 0; i < static_cast<int>(result_armadillo.n_rows); ++i) {
        for (int j = 0; j < static_cast<int>(result_armadillo.n_cols); ++j) {
            if (result_armadillo(i, j) != 2.0) {
                std::cout << "Erro no resultado Armadillo ..." << std::endl;
                return -1;
            }
        }
    }

    std::chrono::duration<double> diff_eigen = stop_eigen - start_eigen;
    std::chrono::duration<double> diff_armadillo = end_armadillo - start_eigen;

    std::cout << "Eigen levou: " << diff_eigen.count() << " segundos." << std::endl;
    std::cout << "Armadillo levou: " << diff_armadillo.count() << " segundos." << std::endl;

    return 0;
}
