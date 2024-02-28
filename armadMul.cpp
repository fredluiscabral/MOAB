#include <armadillo>
#include <iostream>
#include <chrono>
int main(int argc, char* argv[]) {
    int N = atoi (argv[1]);

    arma::mat A = arma::ones(N, N) * 2.0; // Matriz de 2.0s
    arma::mat I = arma::eye(N, N); // Matriz identidade
    
    auto start = std::chrono::high_resolution_clock::now();
    arma::mat B = A * I; // Multiplicação de matrizes
    auto end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> diff = end - start;
    std::cout << "Tempo necessário: " << diff.count() << " segundos." << std::endl;
    
    return 0;
}