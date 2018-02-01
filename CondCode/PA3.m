function  PA3(N, M, r, l, t, b)
%20 x 20 mesh
if ~isempty(N) && ~isempty(M)
    n = N;
    m = M;
else
    n = 20;     %x direction
    m = 20;     %y direction

end

if t>0 & b>0 & r>0 & l>0
    right = r;
    left = l;
    top = t;
    bot = b;
else
    right = 1;
    left = 0;
    top = 0;
    bot = 0;
end
T1 = top;
T2 = bot;

global V;

for i = 1:m
    for j = 1:n
        if i-1 <= 0                             %top wall
            if j-1 <= 0
                V(i,j) = (V(i+1,j) + V(i,j) + V(i,j+1) + left)/4;
                
            elseif j+1 > n
                V(i,j) = (V(i+1,j) + left + V(i,j) + V(i,j-1))/4;
                
            else
                V(i,j) = (V(i+1,j) + left + V(i,j+1) + V(i,j-1))/4;
                
            end
        end
        if i+1 > m                              %bottom wall
            if j-1 <= 0
                V(i,j) = (V(i-1,j) + V(i,j) + V(i,j+1) + left)/4;
                
            elseif j+1 > n 
                V(i,j) = (V(i,j) + V(i-1,j) + right + V(i,j-1))/4;
                
            else
                V(i,j) = (V(i,j) + V(i-1,j) + V(i,j+1) + V(i,j-1))/4;
                
            end
        end
        if j-1 <= 0                            %left nodes
            if i-1<=0
                V(i,j) = (V(i,j) + V(i+1,j) + V(i,j+1) + left)/4;
                
            elseif i+1>m
                V(i,j) = (V(i-1,j) + V(i,j) + V(i,j+1) + left)/4;
                
            else
                V(i,j) = (V(i-1,j) + V(i+1,j) + V(i,j+1) + left)/4;
                
            end          
        end
        if j+1>n                               %right nodes
            if i-1<=0
                V(i,j) = (V(i,j) + V(i+1,j) + right + V(i,j-1))/4;
                
            elseif i+1>m
                V(i,j) = (V(i-1,j) + V(i,j) + right + V(i,j-1))/4;
                
            else
                V(i,j) = (V(i-1,j) + V(i+1,j) + right + V(i,j-1))/4;
                
            end
            
        end                      
        if i>1 && i<n && j>1 && j<n           %interrior nodes
            V(i,j) = (V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1))/4;
        end
                
        T1 = V(i,j);      %for a bottom node
        T2 = V(i,j);      %for a top node
    end
end
end