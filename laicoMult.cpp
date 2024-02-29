#include "bural.h"
#include <iostream>
#include <chrono>
#include <Eigen/Dense>
#include <armadillo>

// Declare a função de multiplicação de matrizes contida na sua biblioteca
//extern "C" void multMatrizes(double* matriz1, double* matriz2, double* resultado, int N);

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cout << "Uso: " << argv[0] << " <tamanho da matriz>" << std::endl;
        return 1;
    }

    int N = atoi(argv[1]);

    std::cout << "Iniciando ..." << std::endl;

    // Criar as matrizes usando Eigen e Armadillo
    Eigen::MatrixXd mat1 = Eigen::MatrixXd::Constant(N, N, 2.0);
    Eigen::MatrixXd iden = Eigen::MatrixXd::Identity(N, N);

    arma::mat A = arma::ones<arma::mat>(N, N) * 2.0;
    arma::mat I = arma::eye<arma::mat>(N, N);

    // Multiplicar matrizes usando sua função

    double *mat1_ptr, *iden_ptr, *resultado_ptr;

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
    std::cout << "Sua função levou: " << diff_custom.count() << " segundos." << std::endl;

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
