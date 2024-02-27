#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>


#define TAM 10000

void somarMatrizes(double matriz1[TAM][TAM], double matriz2[TAM][TAM], double resultado[TAM][TAM], int N, int thread_id, int num_threads) {
    //int inicio = thread_id * (N / num_threads);
    //int fim = (thread_id == num_threads - 1) ? N : (thread_id + 1) * (N / num_threads);
    
    int tamanho, resto, inicio, fim;
    
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
    

    for (int i = inicio; i < fim; ++i) {
        for (int j = 0; j < N; ++j) {
            double sum = 0.0;
            for (int k = 0; k < N; ++k) {
                        sum += matriz1[i][k] * matriz2[k][j];
            }
            resultado[i][j] = sum;
        }
    }
    
}

void imprimirMatriz(int **matriz, int N) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%d ", matriz[i][j]);
        }
        printf("\n");
    }
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <tamanho da matriz N>\n", argv[0]);
        return 1;
    }
 
    int num_threads;

    int N = atoi(argv[1]);

    // double **matriz1, **matriz2, **resultado;

     double t_i, t_f;
/*

    // Alocar memória para as matrizes
    matriz1 = (double **)malloc(N * sizeof(double *));
    matriz2 = (double **)malloc(N * sizeof(double *));
    resultado = (double **)malloc(N * sizeof(double *));

    for (int i = 0; i < N; i++) {
        matriz1[i] = (double *)malloc(N * sizeof(double));
        matriz2[i] = (double *)malloc(N * sizeof(double));
        resultado[i] = (double *)malloc(N * sizeof(double));
    }
*/


   double matriz1[TAM][TAM];
   double matriz2[TAM][TAM];
   double resultado[TAM][TAM];


    // Preencher as matrizes com elementos aleatórios
    srand(time(NULL));

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            matriz1[i][j] = 2.0; //rand() % 100;
	    if (i==j)
            	matriz2[i][j] = 1.0; //rand() % 100;
	    else
		matriz2[i][j] = 0.0;    
        }
    }

    // Iniciar região paralela
    #pragma omp parallel
    {

        num_threads = omp_get_num_threads();
        int thread_id = omp_get_thread_num();

/*
        printf("Thread %d iniciada...\n", thread_id);
*/
        t_i = omp_get_wtime();
        
        // Calcular a soma das matrizes de forma paralela
        somarMatrizes(matriz1, matriz2, resultado, N, thread_id, num_threads);

        t_f = omp_get_wtime();

    }

    int passou = 1;

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (matriz1[i][j] != 2.0)
		    passou = 0;
        }
    }

    if (passou == 1)
	    printf ("Passou !!!\n");
    else
	    printf ("Falhou !!!\n");



    printf ("%d ; %.10f\n", num_threads,(double)(t_f - t_i));

/*
    printf("\nMatriz 1:\n");
    imprimirMatriz(matriz1, N);

    printf("\nMatriz 2:\n");
    imprimirMatriz(matriz2, N);

    printf("\nResultado da soma:\n");
    imprimirMatriz(resultado, N);
*/

/*    
    // Liberar memória alocada
    for (int i = 0; i < N; i++) {
        free(matriz1[i]);
        free(matriz2[i]);
        free(resultado[i]);
    }
    free(matriz1);
    free(matriz2);
    free(resultado);
*/

    return 0;
}

