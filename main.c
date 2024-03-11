#include <stdio.h>
#include <stdlib.h>
#include "bural.h"
#include <omp.h> // Garante que omp_get_wtime() possa ser utilizado

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <tamanho da matriz>\n", argv[0]);
        return 1;
    }

    int N = atoi(argv[1]);
    int N2 = N * N; // Tamanho da matriz resultante do produto de Kronecker

    double *matriz1, *matriz2, *resultado, *resultadoKronecker;

    // Alocar memória para as matrizes
    matriz1 = (double *)malloc(N * N * sizeof(double));
    matriz2 = (double *)malloc(N * N * sizeof(double));
    resultado = (double *)malloc(N * N * sizeof(double));
    resultadoKronecker = (double *)malloc(N2 * N2 * sizeof(double)); // Matriz maior para o produto de Kronecker

    // Preencher as matrizes com elementos constantes (por exemplo, 2.0 e 3.0 para verificar o produto de Kronecker)
    preencherMatrizes(matriz1, N, 2); // Assumindo que essa função preencha uma matriz com valor especificado
    preencherMatrizes(matriz1, N, 3); // Assumindo que essa função preencha uma matriz com valor especificado
    double t_i = omp_get_wtime();

    // Calcular a multiplicação das matrizes de forma paralela
    multMatrizes(matriz1, matriz2, resultado, N);

    double t_f = omp_get_wtime();
    printf("Multiplicação de matrizes levou %.10f segundos\n", (double)(t_f - t_i));

    // Realizar o produto de Kronecker
    t_i = omp_get_wtime();
    produtoKronecker(matriz1, matriz2, resultadoKronecker, N); // Assumindo a existência desta função
    t_f = omp_get_wtime();
    printf("Produto de Kronecker levou %.10f segundos\n", (double)(t_f - t_i));

    // Verificação do resultado do produto de Kronecker
    // Considerando matriz1 e matriz2 preenchidas com 2.0 e 3.0, respectivamente
    int passou = 1;
    for (int i = 0; i < N2 * N2; i++) {
        if (resultadoKronecker[i] != 6.0) { // 2 * 3 = 6
            passou = 0;
            break;
        }
    }

    if (passou == 1)
        printf("Produto de Kronecker correto.\n");
    else
        printf("Erro no Produto de Kronecker.\n");

    // Liberar a memória alocada
    free(matriz1);
    free(matriz2);
    free(resultado);
    free(resultadoKronecker);

    return 0;
}
