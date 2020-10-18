# Makefile generated at Tue  4 Aug 15:50:52 AEST 2020

CC = gcc
CFLAGS = -Wall -g

main:	a.o	c.o	b.o	bb.o	aaa.o	main.o
	$(CC) $(CFLAGS) -o $@ a.o c.o b.o bb.o aaa.o main.o

a.o:	a.c	a.h	common.h
c.o:	c.c	c.h
b.o:	bb.h	b.h	b.c	aaa.h
bb.o:	bb.h	aaa.h	bb.c
main.o:	main.c	aaa.h	a.h	b.h	bb.h	c.h
