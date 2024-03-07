// Arquivo: matmul_lib.c

#include "bural.h"

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
        
        for (int i = inicio; i < fim; ++i) {
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

void alocarMatrizes(double** matriz1, double** matriz2, double** resultado, int N) {
    *matriz1 = (double*)malloc(N * N * sizeof(double));
    *matriz2 = (double*)malloc(N * N * sizeof(double));
    *resultado = (double*)malloc(N * N * sizeof(double));
}
