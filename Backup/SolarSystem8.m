%Simulates the Inner Solar System - Moon -Mercury

MAX = input('How many days total? ');
SPEED = input('How many days/calculation? ');

t0=2456196.500000000; %A.D. 2012-Sep-26 00:00:00.0000 (CT)

Position = [-1.870576170280912E-03 -2.276808706888534E-03 -2.947659524976667E-05        %Sun
    2.011727067198421E-01  6.892398818134562E-01 -2.272396699056594E-03                 %Venus
    9.991843644789098e-01  5.256748194334550e-02 -3.549380938721226e-05                 %Earth
    -1.821200522982542E-01 -1.461442690172863E+00 -2.617558161376054E-02]                %Mars
    
    

Velocity = [5.871440957897098E-06  -2.377998352013915E-06  -1.270032360750062E-07       %Sun
    -1.946871754111526E-02  5.598272763645390E-03  1.200557313341306E-03                %Venus
    -1.220554367621907e-03   1.710719485202113e-02  -8.176990466583196e-07              %Earth
    1.442333595786848E-02 -5.173157441687048E-04 -3.649109246972166E-04]                 %Mars
    

Mass = [1.9884e+30, 4.869*10^24, 5.972*10^24 + 7.3459*10^22, 6.4185*10^23]

axis equal;
axis([-2,2,-2,2,-.2,.2]);
Gravity(Position,Velocity,Mass,SPEED,MAX,axis);