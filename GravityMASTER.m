function Save = GravityMASTER(Position,Velocity,Mass,SPEED,TIME,Interactions)

%Constants
T = TIME/SPEED;
DeltaT = SPEED;
N = length(Mass);
G = 1.488*10^-34; %AU^3/(kg*day^2)				%6.67*10^-11; %Nm^2/kg^2

%Variables
%Acc = zeros(N,3);
Vel = Velocity;
Pos = Position;
Save = zeros(N,3,T);

d=0; %used for print loop

function S = addSave(current,PosMatrix)
    for n = 1:N
        for i = 1:3
            Save(n,i,current) = PosMatrix(n,i);
        end
    end
    S = Save;
end

addSave(1,Pos);

disp('The program is:');
for t = 2:T                                                             %The main time loop
    Force = zeros(N,3);
    parfor q = 1:N                                                          %This loop controls which item we are calculating the force on
        if Interactions(q) > 0
                w = Interactions(q);
                P = Pos(q,:);
                Q = Pos(w,:);                                           

                F = G * Mass(q)*Mass(w)/(norm(Q-P)^2);                  
                vF = F .* (Q-P)./norm(Q-P);
                Force(q,:) = vF + Force(q,:);                               %Calculate the force on object n from i
        elseif Interactions(q) == 0
            for w = 1:N                                                     %This loop controls which item we are calculating the force from
                if w ~= q                                                   %Don't exert any force on yourself now!
                    P = Pos(q,:);
                    Q = Pos(w,:);                                           %#ok<PFBNS>

                    F = G * Mass(q)*Mass(w)/(norm(Q-P)^2);                  %#ok<PFBNS>
                    vF = F .* (Q-P)./norm(Q-P);
                    Force(q,:) = vF + Force(q,:);                           %Calculate the force on object n from i
                end
            end
        end
    end

    parfor r = 1:N
        %Acc(r,:) = Force(r,:) / Mass(r);
        Pos(r,:) = 1/2 * (Force(r,:) / Mass(r)) * DeltaT^2 + Vel(r,:)*DeltaT + Pos(r,:);
        Vel(r,:) = (Force(r,:) / Mass(r)) * DeltaT + Vel(r,:);
    end

    addSave(t,Pos);
    
    percent = t/T*100;
    if percent >= 5*d
         fprintf('%d%s\n',round(percent),'% done');
         d = d+1;
    end

end

end