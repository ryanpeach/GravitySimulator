function Pos = GravityORIGINAL(Position,Velocity,Mass,SPEED,MAX)

%Constants
G = 1.488*10^-34; %AU^3/(kg*day^2)               %6.67*10^-11; %Nm^2/kg^2
N = length(Mass);
T = MAX/SPEED;

%Variables
Pos = zeros(N,3,T);
Pos(:,:,1) = Position;

Vel = zeros(N,3,T);
Vel(:,:,1) = Velocity;

%Functions
    function vF = Force(P,Q,mp,mq)
        F = G * mp*mq/(norm(Q-P)^2);
        vF = F .* (Q-P)./norm(Q-P);
    end

    function vAcc = Acceleration(P,Q,mq)
        Acc = G * mq/(norm(Q-P)^2);
        vAcc = Acc .* (Q-P)./norm(Q-P);
    end

%Calculate Positions
    for t = 2:T
        newPos = zeros(N,3,1);
        newVel = zeros(N,3,1);
        netF   = zeros(N,3,1);
        
        for p = 1:N
            for q = 1:N
                if(p~=q)
                    netF(p,:,1) = netF(p,:,1) + Force(Pos(p,:,t-1),Pos(q,:,t-1),Mass(p),Mass(q));
                end
            end
        end
        
        for p = 1:N
            newVel(p,:,1) = (netF(p,:) ./ Mass(p)) .* SPEED + Vel(p,:,t-1);
            newPos(p,:,1) = .5 .* (netF(p,:) ./ Mass(p)) .* (SPEED^2) + Vel(p,:,t-1) .* SPEED + Pos(p,:,t-1);
            %keyboard;
        end
        
        Vel(:,:,t) = newVel;
        Pos(:,:,t) = newPos;
    end

end