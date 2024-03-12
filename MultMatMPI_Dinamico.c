#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

void multMatrizesMPI(double* local_A, double* B, double* local_C, int N, int local_rows) {
    for (int i = 0; i < local_rows; ++i) {
        for (int j = 0; j < N; ++j) {
            double sum = 0.0;
            for (int k = 0; k < N; ++k) {
                sum += local_A[i * N + k] * B[k * N + j];
            }
            local_C[i * N + j] = sum;
        }
    }
}

int main(int argc, char *argv[]) {
    int rank, size, N;
    double *A, *B, *C, *local_A, *local_C;
    double t_i, t_f;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (argc != 2) {
        if(rank == 0) {
            printf("Uso: mpirun -np <num_procs> %s <tamanho da matriz>\n", argv[0]);
        }
        MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    N = atoi(argv[1]);
    int local_rows = N / size;

    if(rank == 0) {
        A = (double *)malloc(N * N * sizeof(double));
        B = (double *)malloc(N * N * sizeof(double));
        C = (double *)malloc(N * N * sizeof(double));

        // Inicializa as matrizes A e B
        for (int i = 0; i < N * N; i++) {
            A[i] = 2.0;
            B[i] = 3.0;
        }
    }

    // Aloca memória para cada processo
    local_A = (double *)malloc(local_rows * N * sizeof(double));
    local_C = (double *)malloc(local_rows * N * sizeof(double));

    // Distribui partes da matriz A
    MPI_Scatter(A, local_rows * N, MPI_DOUBLE, local_A, local_rows * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    // Envia a matriz B completa para todos os processos
    MPI_Bcast(B, N * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    t_i = MPI_Wtime();
    multMatrizesMPI(local_A, B, local_C, N, local_rows);
    t_f = MPI_Wtime();

    // Coleta as partes calculadas da matriz C
    MPI_Gather(local_C, local_rows * N, MPI_DOUBLE, C, local_rows * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    if(rank == 0) {
        // Verifica o resultado
        int passou = 1;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (C[i*N+j] != 2.0*3.0*N){
                    passou = 0;
                    break;
                }    
            }
        }

        if (passou == 1)
            printf("Passou !!!\n");
        else
            printf("Falhou !!!\n");

        printf("Tempo: %.10f segundos\n", t_f - t_i);

        free(A);
        free(B);
        free(C);
    }

    free(local_A);
    free(local_C);

    MPI_Finalize();

    return 0;
}
