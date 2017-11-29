#include "link.h"

using namespace std;

#define WINLEN 800
#define WINHEI 600
#define XMID WINLEN/2
#define YMID WINHEI/2



int displayG(vector<vector<pair<int,double> > > funcs, int xmin, int xmax)

{

    // création de la fenêtre

    int ratio=50;
    int xOri=XMID;
    int yOri=YMID;
    bool air = false;
    sf::RenderWindow window(sf::VideoMode(WINLEN, WINHEI), "Projet THL");
    sf::Color colors[7];
    colors[0] = sf::Color::Black;
    colors[1] = sf::Color::Blue;
    colors[2] = sf::Color::Green;
    colors[3] = sf::Color::Yellow;
    colors[4] = sf::Color::Magenta;
    colors[5] = sf::Color::Cyan;
    colors[6] = sf::Color::Red;

    if(xmin == xmax){
        ratio = 50;
        xOri = XMID;
    }
    else{
        ratio = 800/(xmax-xmin);
        xOri = -xmin*ratio;
    }
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
                        ratio+=2;
                        break;
                    case sf::Keyboard::Equal:
                        ratio+=2;
                        break;
                    case sf::Keyboard::Subtract:
                        if(ratio <= 1){break;}
                        ratio-=2;
                        break;
                    case sf::Keyboard::Dash:
                        if(ratio <= 1){break;}
                        ratio-=2;
                        break;
                    case sf::Keyboard::Left:
                        xOri-=2;
                        break;
                    case sf::Keyboard::Right:
                        xOri+=2;
                        break;
                    case sf::Keyboard::Up:
                        yOri-=2;
                        break;
                    case sf::Keyboard::Down:
                        yOri+=2;
                        break;
                    case sf::Keyboard::A:
                        air = !air;
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

            sf::VertexArray courbe(sf::LinesStrip, WINLEN);
            sf::VertexArray aires(sf::Lines, 2);
            int col = 0;
            for (auto f : funcs){
                for(int i=0; i<WINLEN;i++){
                    double x = (i-xOri)/(ratio*1.);
                    double y = function_eval(f,x);
                    int yA = y*ratio;
                    courbe[i].position = sf::Vector2f(i ,yOri - yA);
                    courbe[i].color = colors[col];
                    if(air==1){
                        if(i%9 == 0){
                            aires[0].position = sf::Vector2f(i,yOri);
                            aires[1].position = sf::Vector2f(i,yOri-yA);
                            aires[0].color = colors[col];
                            aires[1].color = colors[col];
                            window.draw(aires);
                        }

                    }
                }
                if(col == 6){col = 0;}
                else col+=1;
                window.draw(courbe);
                

            }
             
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

            /*sf::Vector2i mouse = sf::Mouse::getPosition(window);
            double mousePos = (mouse.x-xOri)/(ratio*1.);

            sf::RectangleShape pos;
            pos.setSize(sf::Vector2f(150,50));
            pos.setPosition(10, WINHEI - 60);
            pos.setFillColor(sf::Color::White);
            pos.setOutlineColor(sf::Color::Black);
            pos.setOutlineThickness(1);



            window.draw(pos);*/



        // fin de la frame courante, affichage de tout ce qu'on a dessiné
        window.display();
    }

    return 0;
}