// Arquivo: main.c

#include <stdio.h>
#include <stdlib.h>
#include "bural.h"

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <tamanho da matriz>\n", argv[0]);
        return 1;
    }
 
    int num_threads;

    int N = atoi(argv[1]);

    double *matriz1, *matriz2, *resultado;

    double t_i, t_f;

    // Alocar memória para as matrizes
    alocarMatrizes(&matriz1, &matriz2, &resultado, N);

    // Preencher as matrizes com elementos constantes
    preencherMatrizes(matriz1, matriz2, N);


    t_i = omp_get_wtime();

    // Calcular a multiplicação das matrizes de forma paralela
    multMatrizes(matriz1, matriz2, resultado, N);

    t_f = omp_get_wtime();


    int passou = 1;

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (matriz1[i*N+j] != 2.0)
                passou = 0;
        }
    }

    if (passou == 1)
        printf("Passou !!!\n");
    else
        printf("Falhou !!!\n");

    printf("Levou %.10f segundos\n", (double)(t_f - t_i));

    free(matriz1);
    free(matriz2);
    free(resultado);

    return 0;
}
