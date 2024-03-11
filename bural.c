// Arquivo: matmul_lib.c

#include "bural.h"
#include <stdio.h>
#include <stdlib.h>

void multMatrizes(double* matriz1, double* matriz2, double* resultado, int N) {

    #pragma omp parallel num_threads(N)
    {

        int num_threads = omp_get_num_threads();
        int thread_id = omp_get_thread_num();

        int tamanho, resto, inicio, fim;
        
        tamanho = (N) / num_threads;
        resto = (N) % num_threads;
        inicio = tamanho * thread_id;
        fim = inicio + tamanho - 1;
        
        if (thread_id + 1 <= resto) {
            inicio = inicio + thread_id;
            fim = fim + thread_id + 1;
        } else {
            inicio = inicio + resto;
            fim = fim + resto;
        }	        		    
        

        for (int i = inicio; i <= fim; ++i) {
            for (int j = 0; j < N; ++j) {
                double sum = 0.0;
                for (int k = 0; k < N; ++k) {
                    sum += matriz1[i * N + k] * matriz2[k * N + j];
                }
                resultado[i * N + j] = sum;
            }
        }

    }

}

void preencherMatrizes(double* matriz1, double* matriz2, int N) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            matriz1[i * N + j] = 2.0;
            if (i == j)
                matriz2[i * N + j] = 1.0;
            else
                matriz2[i * N + j] = 0.0;
        }
    }
}

void preencherMatrizComValor(double* matriz, int N, double valor) {
    for (int i = 0; i < N * N; i++) {
        matriz[i] = valor;
    }
}

// Implementações das funções, incluindo alocarMatriz
void alocarMatriz(double** matriz, int N) {
    *matriz = (double*)malloc(N * N * sizeof(double));
    if (*matriz == NULL) {
        fprintf(stderr, "Falha na alocação de memória\n");
        exit(EXIT_FAILURE);
    }
}


void produtoKronecker(double* A, double* B, double* C, int N) {
    int N2 = N * N; // Dimensão da matriz resultante é N^2 x N^2
    #pragma omp parallel num_threads(N2*N2)
    {
        int num_threads = omp_get_num_threads();
        int thread_id = omp_get_thread_num();

        // Divisão do trabalho entre as threads de forma mais apropriada.
        int inicio = (N2 * N2 * thread_id) / num_threads;
        int fim = (N2 * N2 * (thread_id + 1)) / num_threads - 1;

        for (int idx = inicio; idx <= fim; ++idx) {
            int i = idx / N2;
            int j = idx % N2;

            // Índices na matriz A e B derivados de i e j.
            int a_i = i / N; 
            int a_j = i % N;
            int b_i = j / N;
            int b_j = j % N;

            // Calculando o produto tensorial.
            C[idx] = A[a_i * N + a_j] * B[b_i * N + b_j];
        }
    }
}





