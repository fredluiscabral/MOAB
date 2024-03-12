#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

void multMatrizes(double* matriz1, double* matriz2, double* resultado, int N, int num_threads) {
    
    #pragma omp parallel num_threads (num_threads)
    {
        int tamanho, resto, inicio, fim;

        int thread_id = omp_get_thread_num();
        
        tamanho = (N)/num_threads;
        resto=(N)%num_threads;
        inicio = tamanho*thread_id;
        fim = inicio + tamanho -1;
        
        if(thread_id+1 <= resto){
            inicio = inicio+thread_id;
            fim = fim+thread_id+1;
        }
        else{
            inicio = inicio+resto;
            fim = fim+resto;
        }	        		    
        
        for (int i = inicio; i <= fim; ++i) {
            for (int j = 0; j < N; ++j) {
                double sum = 0.0;
                for (int k = 0; k < N; ++k) {
                            sum += matriz1[i*N+k] * matriz2[k*N+j];
                }
                resultado[i*N+j] = sum;
            }
        }
    }    
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Uso: %s <tamanho da matriz> <numero de threads>\n", argv[0]);
        return 1;
    }
     
    int N = atoi(argv[1]);
    int num_threads = atoi (argv[2]);

    double *matriz1, *matriz2, *resultado;
    double t_i, t_f;

    // Alocar memória para as matrizes
    matriz1 = (double *)malloc(N*N * sizeof(double));
    matriz2 = (double *)malloc(N*N * sizeof(double));
    resultado = (double *)malloc(N*N * sizeof(double));

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            matriz1[i*N+j] = 2.0;
            matriz2[i*N+j] = 3.0;
        }
    }
        
    // Calcular a soma das matrizes de forma paralela
    t_i = omp_get_wtime();
    multMatrizes(matriz1, matriz2, resultado, N, num_threads);
    t_f = omp_get_wtime();

    int passou = 1;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (resultado[i*N+j] != 2.0*3.0*N){
		        passou = 0;
                break;
            }    
        }
    }


    if (passou == 1)
	    printf ("Passou !!!\n");
    else
	    printf ("Falhou !!!\n");

    printf ("%d ; %.10f\n", num_threads,(double)(t_f - t_i));

    free(matriz1);
    free(matriz2);
    free(resultado);

    return 0;
}

