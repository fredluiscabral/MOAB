// Arquivo: matmul_lib.h

#ifndef MATMUL_LIB_H
#define MATMUL_LIB_H

#include <stdlib.h>
#include <omp.h>

// Função para multiplicação de matrizes
void multMatrizes(double* matriz1, double* matriz2, double* resultado, int N);

// Função para preencher matrizes com valores constantes
void preencherMatrizes(double* matriz1, double* matriz2, int N);

// Função para alocar memória para as matrizes
void alocarMatrizes(double** matriz1, double** matriz2, double** resultado, int N);

#endif // MATMUL_LIB_H
