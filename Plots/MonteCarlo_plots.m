load("Ising_canonical_L20_T2.0_NMCsteps8.dat")
load("Ising_canonical_L100_T2.0_NMCsteps8.dat")
load("Ising_canonical_L100_T2.1_NMCsteps8.dat")
load("Ising_canonical_L100_T2.2_NMCsteps8.dat")
load("Ising_canonical_L100_T2.3_NMCsteps8.dat")
load("Ising_canonical_L100_T2.27_NMCsteps8.dat")
load("Ising_canonical_L100_T2.6_NMCsteps8.dat")
Ising_canonical_L100_T2_0_NMCsteps8 = [Ising_canonical_L100_T2_0_NMCsteps8(1:100:end,1) Ising_canonical_L100_T2_0_NMCsteps8(1:100:end,2)];
Ising_canonical_L100_T2_1_NMCsteps8 = [Ising_canonical_L100_T2_1_NMCsteps8(1:100:end,1) Ising_canonical_L100_T2_1_NMCsteps8(1:100:end,2)];
Ising_canonical_L100_T2_27_NMCsteps8 = [Ising_canonical_L100_T2_27_NMCsteps8(1:100:end,1) Ising_canonical_L100_T2_27_NMCsteps8(1:100:end,2)];
Ising_canonical_L100_T2_3_NMCsteps8 = [Ising_canonical_L100_T2_3_NMCsteps8(1:100:end,1) Ising_canonical_L100_T2_3_NMCsteps8(1:100:end,2)];
Ising_canonical_L100_T2_27_NMCsteps8 = [Ising_canonical_L100_T2_27_NMCsteps8(1:100:end,1) Ising_canonical_L100_T2_27_NMCsteps8(1:100:end,2)];
Ising_canonical_L100_T2_6_NMCsteps8 = [Ising_canonical_L100_T2_6_NMCsteps8(1:100:end,1) Ising_canonical_L100_T2_6_NMCsteps8(1:100:end,2)];
Ising_canonical_L100_T2_0_NMCsteps8 = [Ising_canonical_L100_T2_0_NMCsteps8(1:100:end,1) Ising_canonical_L100_T2_0_NMCsteps8(1:100:end,2)];
Ising_canonical_L20_T2_0_NMCsteps8 = [Ising_canonical_L20_T2_0_NMCsteps8(1:100:end,1) Ising_canonical_L20_T2_0_NMCsteps8(1:100:end,2)];

figure(1)
plot(Ising_canonical_L100_T2_0_NMCsteps8(10:end,1))
hold on
plot(Ising_canonical_L100_T2_27_NMCsteps8(10:end,1))
plot(Ising_canonical_L100_T2_6_NMCsteps8(10:end,1))
xlabel("n_M_C")
ylabel("Energy")
legend('T=2.0', 'T=2.27','T=2.6')
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*100)             % Relabel 'XTick' With 'XTickLabel' Values

figure(2)
plot(Ising_canonical_L100_T2_0_NMCsteps8(10:end,2))
hold on
plot(Ising_canonical_L100_T2_27_NMCsteps8(10:end,2))
plot(Ising_canonical_L100_T2_6_NMCsteps8(10:end,2))
xlabel("n_M_C")
ylabel("Magnetization")
legend('T=2.0', 'T=2.27','T=2.6')
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*100)  


figure(3)
plot(Ising_canonical_L20_T2_0_NMCsteps8(10:end,1))
hold on
plot(Ising_canonical_L100_T2_0_NMCsteps8(10:end,1))
xlabel("n_M_C")
ylabel("Energy")
legend('L=20', 'L=100)')
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*100) 

figure(4)
plot(Ising_canonical_L20_T2_0_NMCsteps8(10:end,2))
hold on
plot(Ising_canonical_L100_T2_0_NMCsteps8(10:end,2))
xlabel("n_M_C")
ylabel("Magnetization")
legend('L=20', 'L=100)')
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*100) 

