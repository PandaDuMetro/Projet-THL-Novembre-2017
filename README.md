# Projet-THL-Novembre-2017

L'objectif de ce projet était de créer un mini language permettant d'afficher la courbe d'une fonction donnée.
Ce projet a été réaliser a l'aide de flex et bison, du language C++ et de la librairie sfml afin de créer des graphiques.

Utilisation du language : 

Pour lancer le projet il faut entrer la commande "make" dans une console
Les fonctions s'entrent via un fichier (code.txt)
une fonction s'appelle comme suit : 

		f(x) = 1 + x

il est possible d'entrer plusieurs fonctions a la suite: 

	f(x) = 1+ x 
	g(x) = 1/x

Pour demander d'afficher une courbe on utilise la commande :

	plot(fonction_a_afficher)

La fonction ne se trace pas encore car il est possible d'afficher plusieurs fonctions sur un graphique :
	
	plot(fonction1)
	plot(fontcion2)

Pour afficher le graphique final on utilise la commande : 

	display

Il est possible de mettre une ligne en commentaire dans le fichier texte comme suit : 

	// Ligne a mettre en commentaire

Les éléments utilisables pour construire une fonction sont : 

	Les opérateurs : '+'' '-'' '*'' '/' '^' (pour une puissance) '!' pour un factoriel
	Les éléments de calculs : tan() sin() cos() acos() asin() atan() sinh() cosh() tanh() log() sqrt() cbrt() exp() abs()
	L'utilisation des complexes n'est pas possible a cause de la manière dont est renvoyé un nombre complexe en C++


Une fois sur le graphique on peut utiliser les touches 6(-) ou =(+) pour zoomer et dézoomer
Et les touches directionnels pour déplace le graph



