%Simulates the Entire Solar System (no Moon, no Mercury)

t0=2456196.500000000; %A.D. 2012-Sep-26 00:00:00.0000 (CT)

Position = [-1.870576170280912E-03 -2.276808706888534E-03 -2.947659524976667E-05        %Sun
    -3.281695159204355E-01 -3.068581895083214E-01  5.023358832308366E-03                %Mercury
    2.011727067198421E-01  6.892398818134562E-01 -2.272396699056594E-03                 %Venus
    9.991843644789098e-01  5.256748194334550e-02 -3.549380938721226e-05                 %Earth
    1.000936051715352E+00  5.072525452541421E-02  1.850338492920425E-04                 %Moon
    -1.821200522982542E-01 -1.461442690172863E+00 -2.617558161376054E-02                %Mars
    2.117346421535097E+00  4.563708612089869E+00 -6.641502582535451E-02                 %Jupiter
    -8.345814724074495E+00 -5.060943424567980E+00  4.201378598907817E-01                %Saturn
    1.993730723190113E+01  2.209913576854301E+00 -2.500880542673681E-01                 %Uranus
    2.641882796363193E+01 -1.419640215251527E+01 -3.164923301532183E-01]                %Neptune
    
    

Velocity = [5.871440957897098E-06  -2.377998352013915E-06  -1.270032360750062E-07       %Sun
    1.346997031152922E-02 -1.929412460197399E-02 -2.811755671820804E-03                 %Mercury
    -1.946871754111526E-02  5.598272763645390E-03  1.200557313341306E-03                %Venus
    -1.220554367621907e-03   1.710719485202113e-02  -8.176990466583196e-07              %Earth
    -7.755041107857262E-04   1.750144788676796E-02   1.375933881464000E-05              %Earth's Moon
    1.442333595786848E-02 -5.173157441687048E-04 -3.649109246972166E-04                 %Mars
    -6.936542895013999E-03  3.536957308679184E-03  1.405321842471975E-04                %Jupiter
    2.591006213627638E-03 -4.783792072387181E-03 -1.965901758068159E-05                 %Saturn
    -4.620564478784684E-04  3.725800646624899E-03  1.978677950753501E-05                %Uranus
    1.465400169841688E-03  2.784171523909070E-03 -9.098796200037618E-05]                %Neptune
    

Mass = [1.9884e+30, 3.3022*10^23, 4.869*10^24, 5.972*10^24, 7.3459*10^22, 6.4185*10^23, 1898.13*10^24, 5.68319*10^26, 86.8103*10^24, 102.41*10^24]

%secondary interactions must be calculated before primary interactions
%secondary interactions must run the same length of time as primary
Interactions = [-1,1,1,1,4,1,1,1,1,1];
Speed = [0,.01,.1,.01,.01,.1,1,1,1,1];
MAX = [0,88,225,365,365,365*2,365*12,365*30,365*84,365*165];

Num = length(Mass);
T=max(MAX)/.01;

Save=zeros(1,3,T,Num);
containsZero = 0;

close all;
figure(1);
hold on;

for n=2:Num        
    if Interactions(n)>0
        Pos(1,:)=zeros(1,3);
        Pos(2,:)=Position(n,:)-Position(Interactions(n),:);
        Vel(1,:)=zeros(1,3);
        Vel(2,:)=Velocity(n,:)-Velocity(Interactions(n),:);
        M(1)=Mass(Interactions(n));
        M(2)=Mass(n);
        
        Output = GravityMASTER(Pos,Vel,M,Speed(n),MAX(n),[-1,1]);
        Save(1,1:3,1:(MAX(n)/Speed(n)),n) = Save(1,1:3,1:(MAX(n)/Speed(n)),Interactions(n))+Output(2,1:3,1:(MAX(n)/Speed(n)));
        GravToExcel(Save(1,1:3,1:(MAX(n)/Speed(n)),n),['SolarSystem' num2str(n) '.cvs']);
        PlotPlanet(Save(1,1:3,1:(MAX(n)/Speed(n)),n));
    else
        containsZero = 1;
    end
end

if containsZero == 1
   %Write Later 
end

hold off;