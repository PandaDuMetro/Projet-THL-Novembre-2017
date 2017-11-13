all:
	rm -f calculette calculette.c calculette.tab.c calculette.tab.h
	flex -o calculette.c calculette.l
	bison -d calculette.y 
	g++ calculette.c calculette.tab.c -o calculette -lm
	clear
	./calculette