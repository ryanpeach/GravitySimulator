%Simulates the Inner Solar System + Moon
%% Constants
MAX = input('How many days total? ');
SPEED = input('How many days/calculation? ');

t0=2456196.500000000; %A.D. 2012-Sep-26 00:00:00.0000 (CT)

%% Initial Planetary Conditions
Position = [-1.870576170280912E-03 -2.276808706888534E-03 -2.947659524976667E-05        %Sun
    -3.281695159204355E-01 -3.068581895083214E-01  5.023358832308366E-03]                %Mercury
    
Velocity = [5.871440957897098E-06  -2.377998352013915E-06  -1.270032360750062E-07       %Sun
    1.346997031152922E-02 -1.929412460197399E-02 -2.811755671820804E-03]                 %Mercury

Mass = [1.9884e+30, 3.3022*10^23]

%% Run
axis=[-2,2,-2,2,-.2,.2];
Gravity2(Position,Velocity,Mass,SPEED,MAX,axis);