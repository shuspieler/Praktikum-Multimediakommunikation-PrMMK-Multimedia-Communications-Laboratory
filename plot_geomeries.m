function  plot_geomeries(cell_array)
for i=1:5
    
    name = cell_array{i,1}
    Matrix = cell_array{i,2}
    [m,n]=size(Matrix);
    
for j=1:m
    X = [Matrix(:,1);Matrix(1,1)]
    Y = [Matrix(:,2);Matrix(1,1)]
end

if  strcmp (name , 'triangle')
    {
        figure
        plot(X,Y)       
        title([name])
    }
elseif strcmp (name , 'line')
    {
         figure
        plot(X,Y)       
        title([name])
    }
elseif strcmp (name , 'point')
    {
         figure
        plot(X,Y)       
        title([name])
    }
elseif strcmp (name , 'rectangle')
    {
         figure
        plot(X,Y)       
        title([name])
    }  
        end
        
end