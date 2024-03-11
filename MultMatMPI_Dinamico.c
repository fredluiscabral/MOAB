#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

// Função para multiplicar matrizes em paralelo usando MPI
void multMatrizesMPI(const double* matriz1, const double* matriz2, double* resultado, int N, int rank, int size) {
    int linhasPorProcesso = N / size; // Linhas de matriz1 distribuídas por processo
    int extra = N % size; // Linhas extras se N não é divisível por size
    int linhas = (rank < extra) ? linhasPorProcesso + 1 : linhasPorProcesso;
    int inicio = rank * linhasPorProcesso + (rank < extra ? rank : extra);
    
    // Buffer para armazenar a submatriz resultante calculada por este processo
    double* subResultado = (double*)malloc(linhas * N * sizeof(double));

    // Cada processo calcula sua parte da matriz resultante
    for (int i = 0; i < linhas; ++i) {
        for (int j = 0; j < N; ++j) {
            double sum = 0.0;
            for (int k = 0; k < N; ++k) {
                sum += matriz1[(i + inicio) * N + k] * matriz2[k * N + j];
            }
            subResultado[i * N + j] = sum;
        }
    }

    // Reúne as submatrizes resultantes de todos os processos na matriz de resultado final no processo raiz
    if (rank < extra) {
        MPI_Gather(subResultado, linhas * N, MPI_DOUBLE, resultado, linhas * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    } else {
        MPI_Gather(subResultado, linhasPorProcesso * N, MPI_DOUBLE, resultado, linhasPorProcesso * N, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    }

    free(subResultado);
}

int main(int argc, char** argv) {
    int rank, size, N;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Argumento: tamanho N da matriz
    if (argc != 2) {
        if (rank == 0) printf("Uso: mpirun -np <procs> %s <N>\n", argv[0]);
        MPI_Finalize();
        return 1;
    }
    N = atoi(argv[1]);

    double *matriz1 = NULL, *matriz2 = NULL, *resultado = NULL;

    // Processo raiz aloca e inicializa as matrizes
    if (rank == 0) {
        matriz1 = (double*)malloc(N * N * sizeof(double));
        matriz2 = (double*)malloc(N * N * sizeof(double));
        resultado = (double*)malloc(N * N * sizeof(double));
        // Inicialização das matrizes
        // Substitua isso pelas suas funções de inicialização
    }

    // Distribui as matrizes para todos os processos
    if (rank == 0) {
        for (int i = 1; i < size; i++) {
            MPI_Send(matriz1, N*N, MPI_DOUBLE, i, 0, MPI_COMM_WORLD);
            MPI_Send(matriz2, N*N, MPI_DOUBLE, i, 0, MPI_COMM_WORLD);
        }
    } else {
        matriz1 = (double*)malloc(N * N * sizeof(double));
        matriz2 = (double*)malloc(N * N * sizeof(double));
        MPI_Recv(matriz1, N*N, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(matriz2, N*N, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }

    // Realiza a multiplicação de matrizes em paralelo
    multMatrizesMPI(matriz1, matriz2, resultado, N, rank, size);

    // Processo raiz pode fazer algo com o resultado
    if (rank == 0) {
        // Exibir ou verificar o resultado
    }

    // Limpeza
    free(matriz1);
    free(matriz2);
    if (rank == 0) free(resultado);

    MPI_Finalize();
    return 0;
}    
