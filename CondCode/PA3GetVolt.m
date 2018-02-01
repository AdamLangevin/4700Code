clearvars
clearvars -GLOBAL
close all
global V;

N = 10;
M = 10;

V = zeros(N,M);
numSims = 100;

figure(1);


for i =1:numSims
    PA3(N,M,[],[],[],[]);  
end

