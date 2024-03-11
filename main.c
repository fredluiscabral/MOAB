#include <stdio.h>
#include <stdlib.h>
#include "bural.h"
#include <omp.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Uso: %s <tamanho da matriz de multiplicação> <tamanho da matriz para Kronecker>\n", argv[0]);
        return 1;
    }

    int N = atoi(argv[1]);
    int N_k = atoi(argv[2]);
    int N2_k = N_k * N_k; // Tamanho da matriz resultante do produto de Kronecker

    double *matriz1, *matriz2, *matrizK1, *matrizK2, *resultadoMultiplicacao, *resultadoKronecker;
    
    // Aloca memória para as matrizes de multiplicação
    alocarMatriz(&matriz1, N);
    alocarMatriz(&matriz2, N);
    alocarMatriz(&resultadoMultiplicacao, N); 

    // Aloca memória para as matrizes do produto de Kronecker
    alocarMatriz(&matrizK1, N_k);
    alocarMatriz(&matrizK2, N_k);
    alocarMatriz(&resultadoKronecker, N2_k);

    // Preenche as matrizes de multiplicação
    preencherMatrizComValor(matriz1, N, 2.0);
    preencherMatrizComValor(matriz2, N, 3.0);

    // Preenche as matrizes para o produto de Kronecker
    preencherMatrizComValor(matrizK1, N_k, 2.0);
    preencherMatrizComValor(matrizK2, N_k, 3.0);

    // Realiza a multiplicação de matrizes
    double t_i = omp_get_wtime();
    multMatrizes(matriz1, matriz2, resultadoMultiplicacao, N);
    double t_f = omp_get_wtime();
    printf("Multiplicação de matrizes levou %.10f segundos\n", (double)(t_f - t_i));

    // Verificação do resultado da multiplicação de matrizes
    int erroMultiplicacao = 0;
    for (int i = 0; i < N * N; i++) {
        if (resultadoMultiplicacao[i] != 2.0 * 3.0 * N) {
            //printf ("%f %d\n", resultadoMultiplicacao[i], i);
            erroMultiplicacao = 1;
            break;
        }
    }

    if (!erroMultiplicacao)
        printf("Resultado da multiplicação de matrizes correto.\n");
    else
        printf("Erro no resultado da multiplicação de matrizes.\n");

    // Realiza o produto de Kronecker
    t_i = omp_get_wtime();
    produtoKronecker(matrizK1, matrizK2, resultadoKronecker, N_k);
    t_f = omp_get_wtime();
    printf("Produto de Kronecker levou %.10f segundos\n", (double)(t_f - t_i));

    // Verificação do resultado do produto de Kronecker
    int erroKronecker = 0;
    for (int i = 0; i < N2_k * N2_k; i++) {
        if (resultadoKronecker[i] != 6.0) { // 2.0 * 3.0
            erroKronecker = 1;
            break;
        }
    }

    if (!erroKronecker)
        printf("Produto de Kronecker correto.\n");
    else
        printf("Erro no Produto de Kronecker.\n");

    free(matriz1);
    free(matriz2);
    free(resultadoMultiplicacao);
    free(matrizK1);
    free(matrizK2);
    free(resultadoKronecker);

    return 0;
}
