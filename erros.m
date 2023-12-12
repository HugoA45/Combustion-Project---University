%programa de cálculo de matrizes de erro relativo do modelo projetado em
%matlab relativamente aos dados obtidos em cantera
load('tmix_cantera');
load('tad_cantera');
load('composicao_cantera');
close all;
global t p
e_tmix=zeros(t,p);
e_tad=zeros(t,p);
e_CO2=zeros(t,p);
e_CO=zeros(t,p);
e_H20=zeros(t,p);
e_H2=zeros(t,p);
e_N2=zeros(t,p);

e_tmix=abs(abs(tmix_cantera)-abs(Tmix))./abs(tmix_cantera)*100;
e_tad=abs(abs(tad_cantera)-abs(Tad))./abs(tmix_cantera)*100;
e_co2=abs(abs(co2_cantera)-abs(x_b))./abs(co2_cantera)*100;
e_co=abs(abs(co_cantera)-abs(x_c))./abs(co_cantera)*100;
e_h2o=abs(abs(h2o_cantera)-abs(x_d))./abs(h2o_cantera)*100;
e_h2=abs(abs(h2_cantera)-abs(x_e))./abs(h2_cantera)*100;
e_n2=abs(abs(n2_cantera)-abs(x_N2))./abs(n2_cantera)*100;
phi=1:0.05:3.75;

figure 
for j=1:t
    plot(phi,e_tmix(j,:));
    hold on
end
xlabel('Equivalence ratio, Phi');
ylabel('Erro no cálculo da Temperatura de Mistura (%)');


figure 
for j=1:t
    plot(phi,e_tad(j,:));
    hold on
end
xlabel('Equivalence ratio, Phi');
ylabel('Erro no cálculo da Temperatura Adiabática (%)');


figure
for j=1:t
    plot(phi,e_co2(j,:));
    hold on
end
xlabel('Equivalence ratio, Phi');
ylabel('Erro no cálculo da fração molar de CO2 (%)');

figure 
for j=1:t
    plot(phi,e_co(j,:));
    hold on
end
xlabel('Equivalence ratio, Phi');
ylabel('Erro no cálculo da fração molar de CO (%)');

figure 
for j=1:t
    plot(phi,e_h2o(j,:));
    hold on
end
xlabel('Equivalence ratio, Phi');
ylabel('Erro no cálculo da fração molar de H20 (%)');

figure 
for j=1:t
    plot(phi,e_h2(j,:));
    hold on
end
xlabel('Equivalence ratio, Phi');
ylabel('Erro no cálculo da fração molar de H2 (%)');

figure 
for j=1:t
    plot(phi,e_n2(j,:));
    hold on
end
xlabel('Equivalence ratio, Phi');
ylabel('Erro no cálculo da fração molar de N2 (%)');

