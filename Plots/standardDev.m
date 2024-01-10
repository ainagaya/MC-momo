M = dlmread('output_binning_L100_T2.4_NMCsteps8.out', ' ', 4, 0);
exponents = [0:16]';
xdata1 = (2.^exponents);
M = [xdata1 M(:,17) M(:,19) M(:,27) M(:,30) M(:,32) M(:,40) M(:,43)];
fun = @(x,xdata) x(1)-x(2).*exp(-xdata./x(3));
%x0 = [1e-5 1e-3 200]; % Bé per 2.27 Energy
x0 = [6.1e-6 6.2e-5 3.5]; % Bé per 2.0 Energy
%x0 = [6.1e-6 6.2e-5 3]; % Bé per 2.6 Energy

x = lsqcurvefit(fun,x0,M(1:15,1),M(1:15,5))
ydata = M(:,5);

figure(1)
semilogx(M(:,1),M(:,5))
hold on 
semilogx(M(:,1),fun(x,M(:,1)))
xlabel('m')
ylabel('$\sigma_{<E>}$',Interpreter='latex')
legend('Binning error','Fit')
%x0 = [1e-5 1e-3 200]; % Bé per 2.27 Mag
x0 = [4.1e-6 6.2e-4 5.5]; % Bé per 2.0 Mag
%x0 = [6.1e-6 6.2e-5 3]; % Bé per 2.6 Mag

x = lsqcurvefit(fun,x0,M(1:15,1),M(1:15,8))
ydata = M(:,8);

figure(4)
semilogx(M(:,1),M(:,8))
hold on 
semilogx(M(:,1),fun(x,M(:,1)))
xlabel('m')
ylabel('$\sigma_{<M>}$',Interpreter='latex')
legend('Binning error','Fit')

M(1,3)
M(1,6)
%%
M = dlmread('output_binning_L100_T2.27_NMCsteps8.out', ' ', 4, 0);
exponents = [0:16]';
xdata1 = (2.^exponents);
M = [xdata1 M(:,17) M(:,19) M(:,27) M(:,30) M(:,32) M(:,40) M(:,43)];

fun = @(x,xdata) x(1)-x(2).*exp(-xdata./x(3));
x0 = [1e-5 1e-3 200]; % Bé per 2.27 Energy
%x0 = [6.1e-6 6.2e-5 3]; % Bé per 2.0 Energy
%x0 = [6.1e-6 6.2e-5 3]; % Bé per 2.6
x = lsqcurvefit(fun,x0,M(1:15,1),M(1:15,5))
ydata = M(:,5);

figure(2)
semilogx(M(:,1),M(:,5))
hold on 
semilogx(M(:,1),fun(x,M(:,1)))
xlabel('m')
ylabel('$\sigma_{<E>}$',Interpreter='latex')
legend('Binning error','Fit')
x0 = [1e-5 1e-3 200]; % Bé per 2.27 Mag
%x0 = [4.1e-6 6.2e-4 5.5]; % Bé per 2.0 Mag
%x0 = [6.1e-6 6.2e-5 3]; % Bé per 2.6 Mag

x = lsqcurvefit(fun,x0,M(1:15,1),M(1:15,8))
ydata = M(:,8);

figure(5)
semilogx(M(:,1),M(:,8))
hold on 
semilogx(M(:,1),fun(x,M(:,1)))
xlabel('m')
ylabel('$\sigma_{<M>}$',Interpreter='latex')
legend('Binning error','Fit')

M(1,3)
M(1,6)
%%
M = dlmread('output_binning_L100_T2.7_NMCsteps8.out', ' ', 4, 0);
exponents = [0:16]';
xdata1 = (2.^exponents);
M = [xdata1 M(:,17) M(:,19) M(:,27) M(:,30) M(:,33) M(:,36) M(:,39)];

fun = @(x,xdata) x(1)-x(2).*exp(-xdata./x(3));
%x0 = [1e-4 1e-4 200]; % Bé per 2.27
%x0 = [6.1e-6 6.2e-5 3]; % Bé per 2.0
x0 = [6.1e-6 6.2e-5 4]; % Bé per 2.6 Energy
x = lsqcurvefit(fun,x0,M(1:15,1),M(1:15,5))
ydata = M(:,5);

figure(3)
semilogx(M(:,1),M(:,5))
hold on 
semilogx(M(:,1),fun(x,M(:,1)))
xlabel('m')
ylabel('$\sigma_{<E>}$',Interpreter='latex')
legend('Binning error','Fit')
%x0 = [1e-5 1e-3 200]; % Bé per 2.27 Mag
%x0 = [4.1e-6 6.2e-4 5.5]; % Bé per 2.0 Mag
x0 = [2.5e-5 6.2e-5 7.5]; % Bé per 2.6 Mag

x = lsqcurvefit(fun,x0,M(1:15,1),M(1:15,8))
ydata = M(:,8);

figure(6)
semilogx(M(:,1),M(:,8))
hold on 
semilogx(M(:,1),fun(x,M(:,1)))
xlabel('m')
ylabel('$\sigma_{<M>}$',Interpreter='latex')
legend('Binning error','Fit')

M(1,3)
M(1,6)

EnergyMeans = [-1.745565 -1.66207 -1.546464 -1.418615 -1.34770 -1.20398 -1.10607 -1.028279];
MagMeans = [0.9113167 0.8687394 0.7846412 0.56285314 0.3277619 0.1007838 0.0632583 0.047775731 ];
errorBarsE = [6.22e-6  1e-5 2.3e-5 1.219e-4 9.5e-5 1.7e-5 1.1e-5 8.586e-6];
errorBarsM = [4.11e-6  1.2e-5 6.6e-5 9.299e-4 9.3e-4 1.2e-4 4.7e-5 2.541e-5];


%%
M = dlmread('output_binning_L100_T3.0_NMCsteps8.out', ' ', 4, 0);
exponents = [0:16]';
xdata1 = (2.^exponents);
M = [xdata1 M(:,17) M(:,18) M(:,26) M(:,29) M(:,32) M(:,35) M(:,38)];

fun = @(x,xdata) x(1)-x(2).*exp(-xdata./x(3));
%x0 = [1e-4 1e-4 200]; % Bé per 2.27
%x0 = [6.1e-6 6.2e-5 3]; % Bé per 2.0
x0 = [6.1e-6 6.2e-5 4]; % Bé per 2.6 Energy
x = lsqcurvefit(fun,x0,M(1:15,1),M(1:15,5))
ydata = M(:,5);

figure(3)
semilogx(M(:,1),M(:,5))
hold on 
semilogx(M(:,1),fun(x,M(:,1)))
xlabel('m')
ylabel('$\sigma_{<E>}$',Interpreter='latex')
legend('Binning error','Fit')
%x0 = [1e-5 1e-3 200]; % Bé per 2.27 Mag
%x0 = [4.1e-6 6.2e-4 5.5]; % Bé per 2.0 Mag
x0 = [2.5e-5 6.2e-5 7.5]; % Bé per 2.6 Mag

x = lsqcurvefit(fun,x0,M(1:15,1),M(1:15,8))
ydata = M(:,8);

figure(6)
semilogx(M(:,1),M(:,8))
hold on 
semilogx(M(:,1),fun(x,M(:,1)))
xlabel('m')
ylabel('$\sigma_{<M>}$',Interpreter='latex')
legend('Binning error','Fit')

M(1,3)
M(1,6)
%%
Temps = [2 2.1 2.2 2.27 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0];
EnergyMeans = [-1.745565 -1.66207 -1.546464 -1.418615 -1.34770 -1.20398 -1.10607 -1.028279 -0.9635293 -0.908136 -0.8599027 -0.817308];
MagMeans = [0.9113167 0.8687394 0.7846412 0.56285314 0.3277619 0.1007838 0.0632583 0.047775731 0.03924300 0.03376394 0.02997013 0.027168137];
errorBarsE = [6.22e-6  1e-5 2.3e-5 1.219e-4 9.5e-5 1.7e-5 1.1e-5 8.586e-6 7.6e-6 6.9e-6 6.5e-6 6.19e-6];
errorBarsM = [4.11e-6  1.2e-5 6.6e-5 9.299e-4 9.3e-4 1.2e-4 4.7e-5 2.541e-5 1.65e-5 1.21e-5 9.4e-6 7.9e-6];

figure(10)
subplot(2,2,1)
plot(Temps,EnergyMeans, '.-',MarkerSize=10)
xlabel('Temperature')
ylabel('E/N')


subplot(2,2,2)
plot(Temps,MagMeans, '.-',MarkerSize=10)
xlabel('Temperature')
ylabel('|M|/N')

subplot(2,2,3)
semilogy(Temps,errorBarsE, '.-',MarkerSize=10)
xlabel('Temperature')
ylabel('$\sigma_{<E>}$',Interpreter='latex')


subplot(2,2,4)
semilogy(Temps,errorBarsM, '.-',MarkerSize=10)
xlabel('Temperature')
ylabel('$\sigma_{<M>}$',Interpreter='latex')