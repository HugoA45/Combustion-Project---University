%main
% Para não ser necessário correr este programa, load('dados_final.mat');
clear; 
load('hf_table');
global MWc3h8 MWch3oh MWcomb MWair T1 p t

% Pontos intervinientes na análise:
% 1 - Entrada de Fuel 
% 2 - Entrada de ar 
% 3 - Mistura adiabática dos caudais 1 e 2

% Nomenclatura utilizada:
% Ti - Temperatura ponto i
% MWi - Massa molar elemento i
% Tmix - Temperatura mistura, nomeadamente T3
% Tad - Temperatura adiabática
% Tref - Temperatura de referência
% x_i - Fração molar componente i
% ntot - Número total de moles nos produtos
% lhvi - Low heating Value no ponto i 

% análise de resultados, dados obtidos:
%

%definição de vários parâmetros úteis à análise
MWch3oh=32.040;
MWc3h8=44.096;
MWcomb=0.7*44.096+0.3*32.040;
MWair=28.85;
T1=300;

p=56; %número de intervalos de phi/56 e o valor máximo para que o programa 
%corra
t=11; %numero de incrementos de 100 K na temperatura de entrada de ar
%Pré-alocação dos dados
T2=zeros(t,p);
Tmix=zeros(t,p);
Tmed=zeros(t,p);
Tad=zeros(t,p);
b=zeros(t,p);
d=zeros(t,p);
e=zeros(t,p);
c=zeros(t,p);
phi=zeros(1,p);
kp_C=zeros(t,p);
n_C=zeros(t,p);
ntot=zeros(t,p);
x_b=zeros(t,p);
x_c=zeros(t,p);
x_d=zeros(t,p);
x_e=zeros(t,p);
x_N2=zeros(t,p);
lhv1=zeros(t,p);
lhv3=zeros(t,p);
rendimento=zeros(t,p);

%análise de várias quantidades, nomeadamente Tmix=f(T2), Tad=f(T2,phi)
%ntot
for j=1:p
    phi(j)=1+(j-1)*0.05;
    for i=1:t
        T2(i,j)=300+(i-1)*100;
        
        % Função cálculo de Temperatura de mistura
        [Tmix(i,j)] = calc_tmix(T2(i,j),j);
        % Cáculo de temperatura intermédia, entre Tmix e Tref
        Tmed(i,j)=(Tmix(i,j)+298)/2;
        % Cálculo da matriz de Temperaturas adiabáticas
        [Tad(i,j),b(i,j),c(i,j), d(i,j), e(i,j)]=...
        calc_tad(Tmed(i,j),Tmix(i,j),phi(j));
        % Cálculo de número total de moles nos produtos
        ntot(i,j)=b(i,j)+c(i,j)+d(i,j)+e(i,j)+3.95/phi(j)*3.76;
        % Cálculo das frações molares dos componentes analisados
        x_b(i,j)=b(i,j)/ntot(i,j);
        x_c(i,j)=c(i,j)/ntot(i,j);
        x_d(i,j)=d(i,j)/ntot(i,j);
        x_e(i,j)=e(i,j)/ntot(i,j);
        x_N2(i,j)=3.95*3.76/(phi(j)*ntot(i,j));
        
        % Cálculo da matriz de constante de reação, referente à reação de 
        % Bourdouard
        [kp_C(i,j)] = calc_kp_c(Tad(i,j)); 
        % Cálculo das matrizes dos lhv 
        [lhv3(i,j)]=calc_lhv3(b(i,j),c(i,j),d(i,j),e(i,j),phi(j));
        [lhv1]=calc_lhv1;
        % Cálculo da matriz de rendimento 
        [rendimento(i,j)] = calcular_rendimento(phi(j),lhv3(i,j),lhv1);
    end   
    
end




