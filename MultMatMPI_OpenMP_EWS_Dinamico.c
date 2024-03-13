#include <mpi.h>
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

void inicializaMatriz(double *matriz, int N, double valor) {
    for (int i = 0; i < N * N; i++) {
        matriz[i] = valor;
    }
}

void multiplySegmentMPI_OpenMP(double *local_A, double *B, double *local_C, int N, int local_rows, int num_threads) {
    #pragma omp parallel num_threads(num_threads)
    {
        int i, j, k;
        double sum;
        int thread_id = omp_get_thread_num();
        int tamanho = local_rows / num_threads;
        int resto = local_rows % num_threads;
        int inicio = tamanho * thread_id + (thread_id < resto ? thread_id : resto);
        int fim = inicio + tamanho - 1 + (thread_id < resto);

        for (i = inicio; i <= fim; ++i) {
            for (j = 0; j < N; ++j) {
                sum = 0.0;
                for (k = 0; k < N; ++k) {
                    sum += local_A[i * N + k] * B[k * N + j];
                }
                local_C[i * N + j] = sum;
            }
        }
    }
}

int main(int argc, char *argv[]) {
    int rank, size, N, num_threads;
    double *A = NULL, *B = NULL, *C = NULL, *local_A = NULL, *local_C = NULL;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (argc != 3) {
        if (rank == 0) fprintf(stderr, "Usage: mpirun -np <num_procs> %s <matrix_size> <num_threads>\n", argv[0]);
        MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    N = atoi(argv[1]);
    num_threads = atoi(argv[2]);
    int local_rows = N / size;

    B = (double *)malloc(N * N * sizeof(double));
    local_A = (double *)malloc(local_rows * N * sizeof(double));
    local_C = (double *)malloc(local_rows * N * sizeof(double));

    if (rank == 0) {
        A = (double *)malloc(N * N * sizeof(double));
        C = (double *)malloc(N * N * sizeof(double));
        inicializaMatriz(A, N, 2.0);
        inicializaMatriz(B, N, 3.0);
    } else {
        inicializaMatriz(B, N, 0.0); // Only necessary for memory allocation; will be overwritten by MPI_Bcast.
    }

    MPI_Scatter(A, local_rows * N, MPI_DOUBLE, local_A, local_rows * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Bcast(B, N * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    double startTime = MPI_Wtime();
    multiplySegmentMPI_OpenMP(local_A, B, local_C, N, local_rows, num_threads);
    double endTime = MPI_Wtime();

    MPI_Gather(local_C, local_rows * N, MPI_DOUBLE, C, local_rows * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        printf("Multiplication completed in %f seconds.\n", endTime - startTime);
        // Optional: Add result verification code here
        int resultadoCorreto = 1;
        for (int i = 0; i < N * N; i++) {
            if (C[i] != 2.0 * 3.0 * N) {
                resultadoCorreto = 0;
                break;
            }
        }

        if (resultadoCorreto) {
            printf("Resultado correto.\n");
        } else {
            printf("Resultado incorreto.\n");
        }
        free(A);
        free(C);
    }

    free(B);
    free(local_A);
    free(local_C);

    MPI_Finalize();
    return 0;
}
