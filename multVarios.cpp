#include <armadillo>
#include <iostream>
#include <chrono>
#include <Eigen/Dense>

int main(int argc, char* argv[]) {
    int N = atoi (argv[1]);

    std::cout << "Iniciando ..." << std::endl;

    arma::mat A = arma::ones(N, N) * 2.0; // Matriz de 2.0s
    arma::mat I = arma::eye(N, N); // Matriz identidade
    
    auto start_armadillo = std::chrono::high_resolution_clock::now();
    arma::mat B = A * I; // Multiplicação de matrizes
    auto end_armadillo = std::chrono::high_resolution_clock::now();

   // Optional: Verify the result
    for (int i = 0; i < B.n_rows; ++i) {
        for (int j = 0; j < B.n_cols; ++j) {
            if (B(i, j) != 2.0) {
                 std::cout << "Error no Armadillo ..." << std::endl;
                 return -1;
            }
        }
    }


    std::chrono::duration<double> diff_armadillo = end_armadillo - start_armadillo;
    std::cout << "Armadillo levou: " << diff_armadillo.count() << " segundos." << std::endl;
    
    Eigen::MatrixXd mat1 = Eigen::MatrixXd::Constant(N, N, 2.0);
    Eigen::MatrixXd iden = Eigen::MatrixXd::Identity(N, N);

    auto start_eigen = std::chrono::high_resolution_clock::now();
    Eigen::MatrixXd result = mat1 * iden;
    auto stop_eigen = std::chrono::high_resolution_clock::now();

    // Optional: Verify the result
    for (int i = 0; i < result.rows(); ++i) {
        for (int j = 0; j < result.cols(); ++j) {
            if (result(i, j) != 2.0) {
                 std::cout << "Erro no Eigen ..." << std::endl;
                 return -1;
            }
        }
    }

    std::chrono::duration<double> diff_eigen = stop_eigen - start_eigen;
    std::cout << "Eigen levou: " << diff_eigen.count() << " segundos." << std::endl;


    return 0;
}
