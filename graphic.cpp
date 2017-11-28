#include "link.h"

using namespace std;

#define WINLEN 800
#define WINHEI 600
#define XMID WINLEN/2
#define YMID WINHEI/2


int displayG(vector<pair<int,double> > f, int defX = XMID, int defX = YMID)
{

    // création de la fenêtre
    sf::RenderWindow window(sf::VideoMode(WINLEN, WINHEI), "Projet THL");
    int ratio = 50;
    int xOri = defX;
    int yOri = defY;
    /*sf::Font font;
    if(!font.loadFromFile("extrabold.ttf")){
        cerr<<"no font file found"<<endl;
    }*/

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
                switch(event.key.code){
                    case sf::Keyboard::Add:
                        ratio++;
                        break;
                    case sf::Keyboard::Equal:
                        ratio++;
                        break;
                    case sf::Keyboard::Subtract:
                        if(ratio <= 1){break;}
                        ratio--;
                        break;
                    case sf::Keyboard::Dash:
                        if(ratio <= 1){break;}
                        ratio--;
                        break;
                    case sf::Keyboard::Left:
                        xOri--;
                        break;
                    case sf::Keyboard::Right:
                        xOri++;
                        break;
                    case sf::Keyboard::Up:
                        yOri--;
                        break;
                    case sf::Keyboard::Down:
                        yOri++;
                        break;
                    default :
                        break;
               }     
                
            }
        }
        
        // effacement de la fenêtre en noir
            window.clear(sf::Color::White);

            sf::VertexArray axes(sf::Lines, 4);
            axes[0].position = sf::Vector2f(xOri, 0);
            axes[1].position = sf::Vector2f(xOri, WINHEI);
            axes[2].position = sf::Vector2f(0, yOri);
            axes[3].position = sf::Vector2f(WINLEN, yOri);

            axes[0].color = sf::Color::Red;
            axes[1].color = sf::Color::Red;
            axes[2].color = sf::Color::Red;
            axes[3].color = sf::Color::Red;
            window.draw(axes);
             
            sf::VertexArray grads(sf::Lines, 2);

            for (int i=0;i<WINLEN;i++){
                double y = (yOri-i)/(ratio*1.);
                double x = (i-xOri)/(ratio*1.);
                if(y== (int)y){
                    grads[0].position = sf::Vector2f(xOri-1, i);
                    grads[1].position = sf::Vector2f(xOri-5, i);
                    grads[0].color = sf::Color::Red;
                    grads[1].color = sf::Color::Red;
                    window.draw(grads);
                }
                if(x== (int)x){
                    grads[0].position = sf::Vector2f(i, yOri+1);
                    grads[1].position = sf::Vector2f(i, yOri+5);
                    grads[0].color = sf::Color::Red;
                    grads[1].color = sf::Color::Red;
                    window.draw(grads);
                }
            }
            
           sf::VertexArray courbe(sf::LinesStrip, WINLEN);
            for(int i=0; i<WINLEN;i++){
                double x = (i-xOri)/(ratio*1.);
                double y = function_eval(f,x);
                int yA = y*ratio;
                courbe[i].position = sf::Vector2f(i ,yOri - yA);
                courbe[i].color = sf::Color::Green;
            }
            window.draw(courbe);

        

        // fin de la frame courante, affichage de tout ce qu'on a dessiné
        window.display();
    }

    return 0;
}