all:
	rm -f calculette calculette.c calculette.tab.c calculette.tab.h
	flex -o calculette.c calculette.l
	bison -d calculette.y 
	g++ -std=c++14 calculette.c calculette.tab.c graphic.cpp -o calculette -lsfml-graphics -lsfml-window -lsfml-system -lm
	clear
	./calculette