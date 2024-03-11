#include <stdio.h>
#include <stdlib.h>
#include "bural.h" // Certifique-se de que este arquivo contém a declaração de alocarMatriz e preencherMatrizComValor
#include <omp.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <tamanho da matriz>\n", argv[0]);
        return 1;
    }

    int N = atoi(argv[1]);
    int N2 = N * N; // Tamanho da matriz resultante do produto de Kronecker
    double *matriz1, *matriz2, *resultado, *resultadoKronecker;

    // Alocar memória para as matrizes usando a nova função alocarMatriz
    alocarMatriz(&matriz1, N);
    alocarMatriz(&matriz2, N);
    alocarMatriz(&resultado, N); // Para a multiplicação de matrizes, o resultado tem tamanho N * N
    alocarMatriz(&resultadoKronecker, N2); // Para o produto de Kronecker, o resultado tem tamanho N2 * N2

    // Preencher as matrizes com valores especificados usando preencherMatrizComValor
    preencherMatrizComValor(matriz1, N, 2.0);
    preencherMatrizComValor(matriz2, N, 3.0);

    double t_i = omp_get_wtime();

    // Calcular a multiplicação das matrizes de forma paralela
    multMatrizes(matriz1, matriz2, resultado, N);

    double t_f = omp_get_wtime();
    printf("Multiplicação de matrizes levou %.10f segundos\n", (double)(t_f - t_i));

    // Realizar o produto de Kronecker
    t_i = omp_get_wtime();
    produtoKronecker(matriz1, matriz2, resultadoKronecker, N);
    t_f = omp_get_wtime();
    printf("Produto de Kronecker levou %.10f segundos\n", (double)(t_f - t_i));

    // Verificação do resultado do produto de Kronecker
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
