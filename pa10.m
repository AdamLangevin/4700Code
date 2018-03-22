close all

Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95,0.7,200);

I = Is*(exp(1.2*V(:)/0.025) -1) + Gp*V(:) + Ib*exp(-1.2/0.025*(V(:) + Vb));
I2 = zeros(length(I),1);

for i = 1:length(V)
   I2(i) = I(i)*normrnd(1,0.2); 
end

figure(1);
plot(V,I);
hold on
plot(V,I2);

figure(2);
semilogy(V,abs(I));
hold on;
semilogy(V,abs(I2));

p1 = polyfit(V',I, 4);
x = -1.95:(0.7+1.95)/200:0.7;
y = polyval(p1,x);

p2 = polyfit(V',I, 8);
y2 = polyval(p2,x);

p3 = polyfit(V', I2, 4);
y3 = polyval(p3,x);

p4 = polyfit(V', I2, 8);
y4 = polyval(p4,x);

figure(1);
plot(x,y);
plot(x,y2);
plot(x,y3);
plot(x,y4);
legend('show');
legend('Ideal Curent','Ideal with Noise','Ideal 4th polyfit','Ideal 8th polyfit','Noise 4th polyfit','Noise 8th polyfit'); 

figure(2);
semilogy(x,abs(y));
semilogy(x,abs(y2));
semilogy(x,abs(y3));
semilogy(x,abs(y4));
legend('show');
legend('Ideal Curent','Ideal with Noise','Ideal 4th polyfit','Ideal 8th polyfit','Noise 4th polyfit','Noise 8th polyfit'); 

FO = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff = fit(V',I,FO);
If = ff(x);

FO1 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff1 = fit(V',I,FO1);
If1 = ff1(x);

FO2 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff2 = fit(V',I,FO2);
If2 = ff2(x);

figure(3);
plot(ff,V',I);

figure(4);
plot(ff1,V',I);

figure(5);
plot(ff2,V',I);

I3 = I;

inputs = V';
targets = I;
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);

net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);

performance = perform(net,targets,outputs)
view(net)
Inn = outputs;

figure(6);
plot(V',I3);
hold on;
plot(V',I);