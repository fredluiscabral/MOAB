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


#include <omp.h>

void produtoKronecker(double* A, double* B, double* C, int N) {
    #pragma omp parallel num_threads(N*N)
    {
        int num_threads = omp_get_num_threads();
        int thread_id = omp_get_thread_num();

        // Cada thread trabalha em uma parte da matriz C.
        int tamanho = (N * N) / num_threads; // Total de elementos divididos pelo número de threads
        int resto = (N * N) % num_threads;
        int inicio = tamanho * thread_id;
        int fim = inicio + tamanho - 1;
        
        if (thread_id < resto) {
            inicio += thread_id; // Threads com menor ID pegam um elemento extra se houver resto
            fim += thread_id + 1;
        } else {
            inicio += resto;
            fim += resto;
        }

        // Cada thread calcula os elementos de C para os quais é responsável
        for (int idx = inicio; idx <= fim; ++idx) {
            // Calcula os índices i e j na matriz resultante C
            int i = idx / (N*N); // Índice da linha em C
            int j = idx % (N*N); // Índice da coluna em C
            
            // Calcula os índices a_i, a_j, b_i, b_j nas matrizes originais A e B
            int a_i = i / N; 
            int a_j = i % N;
            int b_i = j / N;
            int b_j = j % N;

            // Produto tensorial de elementos (Kronecker)
            C[idx] = A[a_i * N + a_j] * B[b_i * N + b_j];
        }
    }
}




