clearvars
close all

x = 0;
xp = 0;

global C
C.kb = 1.3806504e-23;
C.m_0 = 9.10938215e-31;
g = 9.81;

scatProb = 0.05;

dt = 10e-15;
TStop = 500*dt;
t = dt;

Vx = -g*dt;
dx = Vx * dt;
x = dx;

color = hsv(1);

%Plot
figure(1);
subplot(2,1,1);
hold on
title('pos vs time');
plot([0 dt], [0 x], 'color', color);

subplot(2,1,2);
hold on
title('vel vs time');
plot([0 dt], [0 Vx]);

sum = 0;

while t < TStop
    pVx = Vx;
    dVx = -g *dt;
    Vx = Vx + dVx;
    dx = Vx *dt - g * dt^2/2;
    
    if rand() <= scatProb               %changes the motion by -20% 
        Vx = -0.2*(Vx - g*dt);
        dx = Vx *dt - g * dt^2/2;
        
    end
    xp = x;
    x = x + dx;
    sum = sum + x;
    
    subplot(2,1,1);
    plot([(t-dt) t], [xp x], 'color', color);
    
    subplot(2,1,2);
    plot([(t-dt) t], [pVx Vx],'color', color);
    pause(0.001);
    t = t + dt;
end
tot = sum/TStop;
title(tot);             
hold off