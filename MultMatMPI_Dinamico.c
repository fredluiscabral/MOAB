#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

void inicializaMatriz(double *matriz, int N, double valor) {
    for (int i = 0; i < N * N; i++) {
        matriz[i] = valor;
    }
}

void multiplySegment(double *local_A, double *B, double *local_C, int N, int local_N) {
    for (int i = 0; i < local_N; i++) {
        for (int j = 0; j < N; j++) {
            double sum = 0.0;
            for (int k = 0; k < N; k++) {
                sum += local_A[i * N + k] * B[k * N + j];
            }
            local_C[i * N + j] = sum;
        }
    }
}

int main(int argc, char *argv[]) {
    int rank, size, N;
    double *A, *B, *C, *local_A, *local_C, startTime, endTime, calcTime, maxCalcTime;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (argc != 2) {
        if (rank == 0) fprintf(stderr, "Usage: mpirun -np <num_procs> %s <N>\n", argv[0]);
        MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    N = atoi(argv[1]);
    int local_N = N / size; // Assumindo que N é divisível por size

    if (rank == 0) {
        A = (double *)malloc(N * N * sizeof(double));
        B = (double *)malloc(N * N * sizeof(double));
        inicializaMatriz(A, N, 2.0);
        inicializaMatriz(B, N, 3.0);
    }

    local_A = (double *)malloc(local_N * N * sizeof(double));
    local_C = (double *)malloc(local_N * N * sizeof(double));

    MPI_Scatter(A, local_N * N, MPI_DOUBLE, local_A, local_N * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Bcast(B, N * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    calcTime = MPI_Wtime();
    multiplySegment(local_A, B, local_C, N, local_N);
    calcTime = MPI_Wtime() - calcTime;

    if (rank == 0) {
        C = (double *)malloc(N * N * sizeof(double));
    }

    MPI_Gather(local_C, local_N * N, MPI_DOUBLE, C, local_N * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    // Verificação do resultado no processo raiz
    if (rank == 0) {
        int correct = 1;
        for (int i = 0; i < N * N; i++) {
            if (C[i] != 6.0 * N) {
                correct = 0;
                break;
            }
        }
        if (correct) {
            printf("Resultado correto.\n");
        } else {
            printf("Resultado incorreto.\n");
        }
        free(C);
    }

    MPI_Finalize();
    free(local_A);
    free(local_C);
    if (rank == 0) {
        free(A);
        free(B);
    }
    return 0;
}
