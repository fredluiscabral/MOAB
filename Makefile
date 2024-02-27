CC=gcc
CFLAGS=-fopenmp -O3 -ftree-vectorize -march=native -fopt-info-vec
TARGET=MultMatEWS_Estatico

all: $(TARGET)

$(TARGET): MultMatEWS_Estatico.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(TARGET)

