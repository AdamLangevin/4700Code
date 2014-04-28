
doPlot = 1;
dt = 5e-15;
TStop = 10000*dt;
InitDist = 0.0;
Method = 'VE'; % VE -- verlot; FD -- Forward Difference

Mass0 = 14*C.am; % Silicon
Mass1 = 5*C.am; % Argon

AtomSpacing = 0.5430710e-9;
LJSigma = AtomSpacing/2^(1/6);
LJEpsilon = 1e-21;

PhiCutoff = 3*AtomSpacing*1.1;

T = 0;

AddRectAtomicArray(10,10,0,0,0,0,0,T,0);
% vy0 = -sqrt(0.02*Ep/Mass1);
% AddRectAtomicArray(4,4,0,12*AtomSpacing,0,vy0,0,T,1);
AddParticleStream(13,0,5*1.2*AtomSpacing,-pi/2,1,0.4*C.q_0);

Size = 15*AtomSpacing;
Limits = [-Size +Size -Size +Size]; % square is good