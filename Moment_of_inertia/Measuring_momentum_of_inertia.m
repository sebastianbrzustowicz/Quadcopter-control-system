clear, close all

g = 9.83; % m/s^2
m = 0.061; % kg
D = 0.365; % m
T = 6.63/10; % 1/s    %6.57
h = 0.293; % m

%dla taśmy
m = 0.107;
T = 12.33/10;   %13.02 %12.28
D = 0.098;
h = 0.39;
r1 = 7.8/2/100;
r2 = 9.8/2/100;



%I = m/12*(0.02^2*cosd(60)+0.015^2*sind(45)+0.365) %dla ukośnego
%prostopadłościanu

%I = m/2*(r2^2+r1^2) %dla taśmy

m = 0.052;
m_nut = 2.2/1000;
l_nut = 0.134;
T = 7.29/10;   %13.02 %12.28
D = 0.348;
h = 0.31;
%r1 = 7.8/2/100;
%r2 = 9.8/2/100;

%I_ek = ((m+12*m_nut)*g*D^(2)*T^(2))/(16*pi*h)
T = 6.51/10/2; l_nut = 0.127;
I_ek1 = (m*g*D^(2)*T^(2))/(16*pi*h)
I1 = m/12*D^2 %pręt bez śrubek    %7.8340e-04 T = 6.51/10; l_nut = 0.127;
T = 6.89/10/2; l_nut = 0.13;
I_ek2 = ((m+6*m_nut)*g*D^(2)*T^(2))/(16*pi*h)
I2 = m/12*D^2 + 2*3*m_nut*l_nut^2 %pręt z 3 śrubkami z każdej strony l_nut = 0.13;  %T = 6.89/10, 6.98, 7.02; %7.3769e-04 
T = 7.29/10/2, l_nut = 0.134;
I_ek3 = ((m+12*m_nut)*g*D^(2)*T^(2))/(16*pi*h)
I3 = m/12*D^2 + 2*6*m_nut*l_nut^2 %T = 7.29/10, 7.22; l_nut = 0.134; 9.9882e-04
T = 7.97/10/2, l_nut = 0.142;
I_ek4 = ((m+18*m_nut)*g*D^(2)*T^(2))/(16*pi*h)
I4 = m/12*D^2 + 2*9*m_nut*l_nut^2 %T = ; l_nut = 0.142;

x = [I_ek1, I_ek2, I_ek3, I_ek4];
y = [I1, I2, I3, I4];

plot(x,y)

nachylenie = y/x