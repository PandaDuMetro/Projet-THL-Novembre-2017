#include "link.h"

using namespace std;

#define WINLEN 800
#define WINHEI 600
#define XMID WINLEN/2
#define YMID WINHEI/2


int displayG(vector<pair<int,double> > f)
{

    // création de la fenêtre
    sf::RenderWindow window(sf::VideoMode(WINLEN, WINHEI), "Graph");
    int ratio = 100;

    // on fait tourner le programme tant que la fenêtre n'a pas été fermée
    while (window.isOpen())
    {
        // on traite tous les évènements de la fenêtre qui ont été générés depuis la dernière itération de la boucle
        sf::Event event;
        while (window.pollEvent(event))
        {
            // fermeture de la fenêtre lorsque l'utilisateur le souhaite
            if (event.type == sf::Event::Closed)
                window.close();
            if (event.type == sf::Event::KeyPressed){
                if (event.key.code == sf::Keyboard::A){
                    ratio++;
                }
                if (event.key.code == sf::Keyboard::Z){
                    ratio--;
                }
            }
        }

        // effacement de la fenêtre en noir
            window.clear(sf::Color::White);

            sf::VertexArray axes(sf::Lines, 4);
            axes[0].position = sf::Vector2f(XMID, 0);
            axes[1].position = sf::Vector2f(XMID, WINHEI);
            axes[2].position = sf::Vector2f(0, YMID);
            axes[3].position = sf::Vector2f(WINLEN, YMID);

            axes[0].color = sf::Color::Red;
            axes[1].color = sf::Color::Red;
            axes[2].color = sf::Color::Red;
            axes[3].color = sf::Color::Red;
            window.draw(axes);
            int xOri = XMID;
            int yOri = YMID; 


           sf::VertexArray courbe(sf::LinesStrip, WINLEN);
            for(int i=0; i<WINLEN;i++){
                float x = (i-XMID)/(ratio*1.);
                float y = function_eval(f,x);
                int yA = y*ratio;
                std::cout<<"x = "<<x<<"  y = "<<y<<std::endl;
                courbe[i].position = sf::Vector2f(i ,YMID - yA);
                courbe[i].color = sf::Color::Green;
            }
            window.draw(courbe);
        

        // fin de la frame courante, affichage de tout ce qu'on a dessiné
        window.display();
    }

    return 0;
}