all: exprtest
	
exprtest: scanner.o parser.tab.o exprtest.o driver.o 
	g++ -Wall -g -o exprtest exprtest.o driver.o parser.tab.o scanner.o

exprtest.o: exprtest.cpp
	g++ -Wall -g -c exprtest.cpp

driver.o: scanner.hpp driver.hpp driver.cpp parser.tab.hpp
	g++ -Wall -g -c driver.cpp

parser.tab.o: parser.tab.hpp parser.tab.cpp expression.hpp scanner.hpp driver.hpp 
	g++ -Wall -g -c parser.tab.cpp

scanner.o: scanner.cpp scanner.hpp parser.tab.hpp
	g++ -Wall -g -c scanner.cpp

scanner.cpp: scanner.ll
	flex -t scanner.ll > scanner.cpp

parser.tab.cpp : parser.ypp
	bison parser.ypp

parser.tab.hpp : parser.ypp
	bison parser.ypp

clean:
	rm -f *.o parser.tab.hpp parser.tab.cpp scanner.cpp location.hh position.hh stack.hh exprtest

