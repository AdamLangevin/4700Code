clearvars

nx = 70;
ny = 50;
G = sparse(nx*ny, nx*ny);
diff = 1;

modesOn = 0;                       %turns on/off the interference with a 1/0

%
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        
        if i == 1                   %left sides
            G(n,:) = 0;
            G(n,n) = 1;
        elseif i == nx              %right sides
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j == 1               %bottom side
            nxn = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nyp = j + 1 +(i-1)*ny;
            
            G(:,n) = 0;
            G(n,n) = 1;
        elseif j == ny              %top side
            nxn = j + (i-2)*ny;
            nyn = j - 1 + (i-1)*ny;
            nyp = j + 1 +(i-1)*ny; 
            
            G(:,n) = 0;
            G(n,n) = 1;
           
        elseif i > 10 && i< 20 && modesOn      %x-well component
            nxn = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nyp = j + 1 +(i-1)*ny;
            nyn = j - 1 + (i-1)*ny;
            
            G(n,n) = -2/diff;
            G(n,nxn) = 1/diff;
            G(n,nxp) = 1/diff;
            G(n,nyp) = 1/diff;
            G(n,nyn) = 1/diff;
            
        elseif j > 10 && j < 20 && modesOn    %y-well component
            nxn = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nyp = j + 1 +(i-1)*ny;
            nyn = j - 1 + (i-1)*ny;
            
            G(n,n) = -2/diff;
            G(n,nxn) = 1/diff;
            G(n,nxp) = 1/diff;
            G(n,nyp) = 1/diff;
            G(n,nyn) = 1/diff;
            
        else                        %interrior            
            nxn = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nyp = j + 1 +(i-1)*ny;
            nyn = j - 1 + (i-1)*ny;
            
            G(n,n) = -4/diff;
            G(n,nxn) = 1/diff;
            G(n,nxp) = 1/diff;
            G(n,nyp) = 1/diff;
            G(n,nyn) = 1/diff;
        end
        
    end
end
figure(10);
spy(G);

[E, D] = eigs(G,9,'SM');

[Ds , Pr] = sort(diag(D));
D = D(Pr,Pr);
E = E(:,Pr);

display((diag(D(1:9, 1:9)))')

figure(1);
K = zeros(nx,ny);
for m = 1:9
    for k = 1:nx
        for l = 1:ny
           n = l + (k-1)*ny;       
           K(k,l) = E(n,10-m);
           
        end
    end
    
    subplot(3,3,m);
    figure(m+1);
    surf(1:ny,1:nx,K);
end
