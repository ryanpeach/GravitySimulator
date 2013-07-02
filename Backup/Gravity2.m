function Pos = Gravity2(Position,Velocity,Mass,SPEED,MAX,AXIS)
% Constants
G = 1.488*10^-34; %AU^3/(kg*day^2)               %6.67*10^-11; %Nm^2/kg^2
N = length(Mass);
T = MAX/SPEED;

% Variables
Pos = zeros(N,3,T);
Pos(:,:,1) = Position;

Vel = zeros(N,3,T);
Vel(:,:,1) = Velocity;

% Functions
function vF = Force(P,Q,mp,mq)
    F = G * mp*mq/(norm(Q-P)^2);
    vF = F .* (Q-P)./norm(Q-P);
end

function vAcc = Acceleration(P,Q,mq)
    Acc = G * mq/(norm(Q-P)^2);
    vAcc = Acc .* (Q-P)./norm(Q-P);
end

% Create Plot
t=1;
X=Pos(:,1,t); Y=Pos(:,2,t); Z=Pos(:,3,t);
h_1 = scatter3(X,Y,Z);

xlabel('x');
ylabel('y');
zlabel('z');
axis(AXIS);
axis equal;
grid on;

% Calculate Positions

    for t = 2:T
        % New Vectors
        newPos = zeros(N,3,1);
        newVel = zeros(N,3,1);
        netF   = zeros(N,3,1);
        
        % Sum Forces
        for p = 1:N
            for q = 1:N
                if(p~=q)
                    netF(p,:,1) = netF(p,:,1) + Force(Pos(p,:,t-1),Pos(q,:,t-1),Mass(p),Mass(q));
                end
            end
        end
        
        % Find Next Velocity & Position
        for p = 1:N
            newVel(p,:,1) = (netF(p,:) ./ Mass(p)) .* SPEED + Vel(p,:,t-1);
            newPos(p,:,1) = .5 .* (netF(p,:) ./ Mass(p)) .* (SPEED^2) + Vel(p,:,t-1) .* SPEED + Pos(p,:,t-1);
            %keyboard;
        end
        
        Vel(:,:,t) = newVel;
        Pos(:,:,t) = newPos;
        
        % Print
        X=newPos(:,1)'; Y=newPos(:,2)'; Z=newPos(:,3)';
        
        set(h_1,'xdata',X);
        set(h_1,'ydata',Y);
        set(h_1,'zdata',Z);
        drawnow
        axis(AXIS);

    end

    keyboard;
    
%Final Plot
X=zeros(N,T);
Y=zeros(N,T);
Z=zeros(N,T);

for n=1:N
    X(n,:)=Pos(n,1,:);
    Y(n,:)=Pos(n,2,:);
    Z(n,:)=Pos(n,3,:);
end 

X = X'; Y = Y'; Z = Z';

h_2 = plot3(X,Y,Z);

xlabel('x');
ylabel('y');
zlabel('z');
axis equal;
axis(AXIS);
grid on;
    
end