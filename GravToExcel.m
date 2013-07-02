function Excel = GravToExcel(GravSave,SaveName)
    T = length(GravSave(1,1,:));
    N = length(GravSave(:,1,1));
    
    Excel = zeros(T,N*3);
    for y=1:T
        for x=1:N
            for z=1:3
                Excel(y,((x-1)*3+1)+(z-1)) = GravSave(x,z,y);
            end
        end
    end
    
    csvwrite(SaveName,Excel);
end