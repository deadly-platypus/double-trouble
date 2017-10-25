CFLAGS :=-g
CC=gcc

all: test.o
	${CC} ${CFLAGS} mmap_test.c -o mmap

test.o:
	${CC} ${CFLAGS} -c test.c

clean:
	rm -rf test.o mmap
