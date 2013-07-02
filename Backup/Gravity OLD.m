function out = Gravity(Pos,Vel,mass,SPEED,MAX)

%constants
G = .498137; %m^3/(kg*day^2)               %6.67*10^-11; %Nm^2/kg^2
N = length(mass);

%variables
t = 1; %1 year in 1 day increments
position = zeros(N,3,MAX/SPEED);
velocity = zeros(N,3,MAX/SPEED);

position(1:N,1:3,t)=Pos;
velocity(1:N,1:3,t)=Vel;

%functions

%P is a (1,3) matrix representing the reference object (sun for example)
%Q is a (n,3) matrix representing the moving objects (earth for example)

    function v = vPosition(P,Q)
        numrows = size(Q);
        numrows = numrows(1);
        for o=1:numrows
            v = Q(o)-P;
        end
    end

    function dir = vDirection(P,Q)
        v = vPosition(P,Q);
        [z,u] = size(v); %get number of rows
        for i=1:z
            dir(i,:)=v(i,:)./norm(v(i,:));
        end
    end

    function d = dist(P,Q)
        %d = sqrt(sum(vPosition(p2,p1).^2));  normal distance formula
        d = sqrt(vPosition(P,Q).^2*ones(3,1)); %matrix distance formula
    end

    %The force onto P because of Q
    function f = force(P,Q,m0,m)
        f0=(G*m0.*m)./(dist(P,Q).^2); %Force of Gravity
        
        

        for g=1:length(f0)
            f(g,:)=f0(g)*vDirection(P,Q);
        end

    end

    %The acceleration of P
    function net = acc(P,Q,m0,m)
        a=force(P,Q,m0,m)./m0;
        net=[sum(a(1:N-1,1)),sum(a(1:N-1,2)),sum(a(1:N-1,3))];
    end
    
for t=2:(MAX/SPEED)
    
    newPosition = zeros(N,3);
    newVelocity = zeros(N,3);
    
    for n=1:N
        Q0=position(:,:,t-1);   %make Q all object positions at that time
        
        P0=position(n,:,t-1);   %pick an object position P
        V0=velocity(n,:,t-1);
        
        Q0(n,:)=[];             %delete P from Q
        
        m0 = mass(n);           %make m0 equal object n mass
        m = mass;               %make m all other object masses
        m(n) = [];                  %by deleting m0 from m
        
        
        
        newVelocity(n,:) = V0 + acc(P0,Q0,m0,m) * SPEED;
        newPosition(n,:) = P0 + .5 * newVelocity(n,:) * SPEED;
        
        
    end
    
    velocity(:,:,t)=newVelocity;
    position(:,:,t)=newPosition;
    
end

out=position(:,:,:);


%Print
X=zeros(N,(MAX/SPEED));
Y=zeros(N,(MAX/SPEED));
Z=zeros(N,(MAX/SPEED));

for n=1:N
    X(n,:)=position(n,1,:);
    Y(n,:)=position(n,2,:);
    Z(n,:)=position(n,3,:);
end 

X = X'; Y = Y'; Z = Z';

plot3(X,Y,Z);
grid on;
xlabel('x');
ylabel('y');
zlabel('z');

end