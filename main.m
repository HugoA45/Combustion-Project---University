%main
% Para n�o ser necess�rio correr este programa, load('dados_final.mat');
clear; 
load('hf_table');
global MWc3h8 MWch3oh MWcomb MWair T1 p t

% Pontos intervinientes na an�lise:
% 1 - Entrada de Fuel 
% 2 - Entrada de ar 
% 3 - Mistura adiab�tica dos caudais 1 e 2

% Nomenclatura utilizada:
% Ti - Temperatura ponto i
% MWi - Massa molar elemento i
% Tmix - Temperatura mistura, nomeadamente T3
% Tad - Temperatura adiab�tica
% Tref - Temperatura de refer�ncia
% x_i - Fra��o molar componente i
% ntot - N�mero total de moles nos produtos
% lhvi - Low heating Value no ponto i 

% an�lise de resultados, dados obtidos:
%

%defini��o de v�rios par�metros �teis � an�lise
MWch3oh=32.040;
MWc3h8=44.096;
MWcomb=0.7*44.096+0.3*32.040;
MWair=28.85;
T1=300;

p=56; %n�mero de intervalos de phi/56 e o valor m�ximo para que o programa 
%corra
t=11; %numero de incrementos de 100 K na temperatura de entrada de ar
%Pr�-aloca��o dos dados
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

%an�lise de v�rias quantidades, nomeadamente Tmix=f(T2), Tad=f(T2,phi)
%ntot
for j=1:p
    phi(j)=1+(j-1)*0.05;
    for i=1:t
        T2(i,j)=300+(i-1)*100;
        
        % Fun��o c�lculo de Temperatura de mistura
        [Tmix(i,j)] = calc_tmix(T2(i,j),j);
        % C�culo de temperatura interm�dia, entre Tmix e Tref
        Tmed(i,j)=(Tmix(i,j)+298)/2;
        % C�lculo da matriz de Temperaturas adiab�ticas
        [Tad(i,j),b(i,j),c(i,j), d(i,j), e(i,j)]=...
        calc_tad(Tmed(i,j),Tmix(i,j),phi(j));
        % C�lculo de n�mero total de moles nos produtos
        ntot(i,j)=b(i,j)+c(i,j)+d(i,j)+e(i,j)+3.95/phi(j)*3.76;
        % C�lculo das fra��es molares dos componentes analisados
        x_b(i,j)=b(i,j)/ntot(i,j);
        x_c(i,j)=c(i,j)/ntot(i,j);
        x_d(i,j)=d(i,j)/ntot(i,j);
        x_e(i,j)=e(i,j)/ntot(i,j);
        x_N2(i,j)=3.95*3.76/(phi(j)*ntot(i,j));
        
        % C�lculo da matriz de constante de rea��o, referente � rea��o de 
        % Bourdouard
        [kp_C(i,j)] = calc_kp_c(Tad(i,j)); 
        % C�lculo das matrizes dos lhv 
        [lhv3(i,j)]=calc_lhv3(b(i,j),c(i,j),d(i,j),e(i,j),phi(j));
        [lhv1]=calc_lhv1;
        % C�lculo da matriz de rendimento 
        [rendimento(i,j)] = calcular_rendimento(phi(j),lhv3(i,j),lhv1);
    end   
    
end




