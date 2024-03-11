#include <stdio.h>
#include <stdlib.h>
#include "bural.h"
#include <omp.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Uso: %s <primeiro tamanho> <segundo tamanho>\n", argv[0]);
        return 1;
    }

    int N = atoi(argv[1]);
    int N_k = atoi(argv[2]); // Corrige a conversão para o segundo tamanho
    int N2 = N_k * N_k; // Tamanho da matriz resultante do produto de Kronecker

    double *matriz1, *matriz2, *resultadoKronecker;

    // Aloca memória para as matrizes
    alocarMatriz(&matriz1, N);
    alocarMatriz(&matriz2, N);
    alocarMatriz(&resultadoKronecker, N2); // A matriz resultadoKronecker é baseada em N_k

    // Preenche as matrizes com valores específicos
    preencherMatrizComValor(matriz1, N, 2.0); // Supõe-se que esta função preenche a matriz1 com 2.0
    preencherMatrizComValor(matriz2, N, 3.0); // Supõe-se que esta função preenche a matriz2 com 3.0

    double t_i = omp_get_wtime();
    
    // Realiza o produto de Kronecker
    produtoKronecker(matriz1, matriz2, resultadoKronecker, N); // A função deve ser implementada para trabalhar com as dimensões corretas

    double t_f = omp_get_wtime();
    printf("Produto de Kronecker levou %.10f segundos\n", (double)(t_f - t_i));

    // Verifica o resultado do produto de Kronecker
    int passou = 1;
    for (int i = 0; i < N2; i++) {
        if (resultadoKronecker[i] != 6.0) { // Considera que a matriz resultante deveria ter todos os elementos iguais a 6 (2*3)
            passou = 0;
            break;
        }
    }

    if (passou == 1)
        printf("Produto de Kronecker correto.\n");
    else
        printf("Erro no Produto de Kronecker.\n");

    // Libera a memória alocada
    free(matriz1);
    free(matriz2);
    free(resultadoKronecker);

    return 0;
}
