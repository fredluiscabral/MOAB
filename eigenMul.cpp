#include <Eigen/Dense>
#include <chrono>
#include <iostream>
//#include <stdlib>

int main(int argc, char* argv[]) {
    int N = atoi (argv[1]);
    Eigen::MatrixXd mat1 = Eigen::MatrixXd::Constant(N, N, 2.0);
    Eigen::MatrixXd iden = Eigen::MatrixXd::Identity(N, N);

    auto start = std::chrono::high_resolution_clock::now();
    Eigen::MatrixXd result = mat1 * iden;
    auto stop = std::chrono::high_resolution_clock::now();

    // Optional: Verify the result
    for (int i = 0; i < result.rows(); ++i) {
        for (int j = 0; j < result.cols(); ++j) {
            if (result(i, j) != 2.0) {
                 std::cout << "Error in multiplication result" << std::endl;
                 return -1;
            }
        }
    }

    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);
    std::cout << "Multiplication took " << duration.count() << " ms." << std::endl;

    return 0;
}
