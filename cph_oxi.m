function [cp,h] = cph_oxi(a,b,T)
% Função cálculo de cp e entalpia de formação de várias espécies
% a - variavel escolha range temperatura 1-0/1000K 2-1000/5000K
% b - variavel escolha species 1-12
% Relativo a tabela A.13 Livro Turns


if a==1 
    load('oxi_coeff_0.mat');
    cp=(cphtable0(b,1)+cphtable0(b,2)*T+cphtable0(b,3)*T^2+...
        cphtable0(b,4)*T^3+cphtable0(b,5)*T^4)*8.314;
    h=(cphtable0(b,1)+cphtable0(b,2)*T/2+cphtable0(b,3)*T^2/3+...
        cphtable0(b,4)*T^3/4+cphtable0(b,5)*T^4/5+cphtable0(b,6)/T)*8.314*T;
    
elseif a==2
    load('oxi_coeff_1000.mat');
    cp=(cphtable1000(b,1)+cphtable1000(b,2)*T+cphtable1000(b,3)*T^2+...
        cphtable1000(b,4)*T^3+cphtable1000(b,5)*T^4)*8.314;
    h=(cphtable1000(b,1)+cphtable1000(b,2)*T/2+cphtable1000(b,3)*T^2/3+...
        cphtable1000(b,4)*T^3/4+cphtable1000(b,5)*T^4/5+cphtable1000(b,6)/T)*8.314;
end