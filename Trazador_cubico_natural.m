function[]=Trazador_cubico_natural()
clc
syms x
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xn=[0.9 1.3 1.9 2.1 2.6 3.0 3.9 4.4 4.7 5.0 6.0 7.0 8.0 9.2 10.5 11.3 11.6 12.0 12.6 13.0 13.3];
yn=[1.3 1.5 1.85 2.1 2.6 2.7 2.4 2.15 2.05 2.1 2.25 2.3 2.25 1.95 1.4 0.9 0.7 0.6 0.5 0.4 0.25];%terminos independientes de los polinomios interpolantes de grado 3
[b,c,d]=Trazador_cubico(xn,yn);%llamado al trazador cubico natural
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Parmetros de salida--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%los yn son los terminos independientes de los polinimios
% b es un vector de coeficientes que acompanan a (x-x(j)) en el polinomio
% c es un vector de coeficientes que acompanan a (x-x(j))^2 en el polinomio
% d es un vector de coeficientes que acompanan a (x-x(j))^3 en el polinomio

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Representación grafica ---------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(xn)-1;%número de polinomios a generar

for i=1:n
      P=yn(i)+b(i)*(x-xn(i))+c(i)*(x-xn(i)).^2+d(i)*(x-xn(i)).^3;
      P=matlabFunction(P);
        hold on;plot(xn(i:i+1),P(xn(i:i+1)),'MarkerEdgeColor','b');
end
scatter(xn,yn,'MarkerEdgeColor','r');legend('trazadores cubicos');hold off;
xlabel('eje x') %coamando xlabel para colocar nombre a el eje x
ylabel('eje y') %coamando label para colocar nombre a el eje y
title('Trazador Cubico Natural')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Informe De resultados---------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b(length(b)+1)=0;
d(length(d)+1)=0;
fileID=fopen('Trazador Cubico Natural.txt','w'); %nombre d e el archivo txt llamado biseccion
Resultados=(1:length(xn))'; %primera columna indica las iteraciones
Resultados(:,2)=xn';  %segunda columna indica los puntos del eje x
Resultados(:,3)=yn'; %tercera columna indica los puntos del eje y
Resultados(:,4)=b';   %cuarta columna indica los coeficientes de x
Resultados(:,5)=c';   %quinta columna indica los coeficientes de x^2
Resultados(:,6)=d';   %sexta columna indica los coeficientes de x^3
fprintf(fileID,'%10s %15s %15s %15s %15s %15s \n','íteraciones','puntos del eje x','puntos del eje y','coef de x','coef de x²','coef de x³');
fprintf(fileID,' %d %12.8f %12.8f %12.8f %12.8f %12.8f\n',Resultados');
fclose(fileID);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo  -----------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[b,c,d]=Trazador_cubico(xn,yn)
n=length(xn);%número de iteraciones
h=xn(2:n)-xn(1:n-1);

for i=2:n-1;
    alfa(i)=3/h(i)*(yn(i+1)-yn(i))-3/h(i-1)*(yn(i)-yn(i-1));
end

l(1)=1;
mu(1)=0;
z(1)=0;

for i=2:n-1;
    l(i)=2*(xn(1,i+1)-xn(1,i-1))-h(i-1)*mu(i-1);
    mu(i)=h(i)/l(i);
    z(i)=(alfa(i)-h(i-1)*z(i-1))/l(i);
end

l(n)=1;
z(n)=0;
c(n)=0;

for i=n-1:-1:1;
    c(i)=z(i)-mu(i)*c(i+1);
    b(i)=(yn(i+1)-yn(i))/h(i)-h(i)*(c(i+1)+2*c(i))/3;
    d(i)=(c(i+1)-c(i))/(3*h(i));
end

end
