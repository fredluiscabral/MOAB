#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

void inicializaMatriz(double *matriz, int N, double valor) {
    for (int i = 0; i < N * N; i++) {
        matriz[i] = valor;
    }
}

void multiplySegment(double *local_A, double *B, double *local_C, int N, int local_N, double *calcTime) {
    double startTime = MPI_Wtime();
    for (int i = 0; i < local_N; i++) {
        for (int j = 0; j < N; j++) {
            double sum = 0.0;
            for (int k = 0; k < N; k++) {
                sum += local_A[i * N + k] * B[k * N + j];
            }
            local_C[i * N + j] = sum;
        }
    }
    *calcTime = MPI_Wtime() - startTime;
}

int main(int argc, char *argv[]) {
    int rank, size, N;
    double *A = NULL, *B = NULL, *C = NULL, *local_A = NULL, *local_C = NULL, calcTime, maxCalcTime;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (argc != 2) {
        if (rank == 0) fprintf(stderr, "Usage: mpirun -np <num_procs> %s <N>\n", argv[0]);
        MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    N = atoi(argv[1]);
    int local_N = N / size; // Assumindo que N é divisível por size

    // Alocação de A apenas no processo raiz
    if (rank == 0) {
        A = (double *)malloc(N * N * sizeof(double));
        C = (double *)malloc(N * N * sizeof(double));
        inicializaMatriz(A, N, 2.0);
    }
    
    // Alocação de B em todos os processos
    B = (double *)malloc(N * N * sizeof(double));
    if(rank == 0) {
        inicializaMatriz(B, N, 3.0);
    }

    local_A = (double *)malloc(local_N * N * sizeof(double));
    local_C = (double *)malloc(local_N * N * sizeof(double));

    MPI_Scatter(A, local_N * N, MPI_DOUBLE, local_A, local_N * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Bcast(B, N * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    multiplySegment(local_A, B, local_C, N, local_N, &calcTime);

    MPI_Gather(local_C, local_N * N, MPI_DOUBLE, C, local_N * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    MPI_Reduce(&calcTime, &maxCalcTime, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        printf("Max calculation time: %f seconds\n", maxCalcTime);
    }

    MPI_Finalize();
    if (rank == 0) {
        free(A);
        free(C);
    }
    free(B);
    free(local_A);
    free(local_C);
    return 0;
}
