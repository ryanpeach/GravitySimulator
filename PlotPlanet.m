function Fig = PlotPlanet(GravSave)

T = length(GravSave(1,1,:));
N = length(GravSave(:,1,1));
M=1000;

if(T<M)
    X=zeros(N,T);
    Y=zeros(N,T);
    Z=zeros(N,T);

    for n=1:N
        X(n,:)=GravSave(n,1,:);
        Y(n,:)=GravSave(n,2,:);
        Z(n,:)=GravSave(n,3,:);
    end
else    
    X=zeros(N,M);
    Y=zeros(N,M);
    Z=zeros(N,M);
    
    parfor n=1:N
        for m=1:M
            X(n,m)=GravSave(n,1,round(T*m/M));
            Y(n,m)=GravSave(n,2,round(T*m/M));
            Z(n,m)=GravSave(n,3,round(T*m/M));
        end
    end
end

X = X'; Y = Y'; Z = Z';

Fig = plot3(X,Y,Z);
grid on;
xlabel('x');
ylabel('y');
zlabel('z');

axis equal;

end