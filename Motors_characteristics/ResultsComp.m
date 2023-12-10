clear, close all
% divide by a_mean to get thrust value (g)
a_mean = 1.6919;

M1 = load('M1.mat');
M2 = load('M2.mat');
M3 = load('M3.mat');
M4 = load('M4.mat');

% calculating average base from first 70 samples and subtracting it
M1.dataTab = M1.dataTab - mean(M1.dataTab([1:70]));
M2.dataTab = M2.dataTab - mean(M2.dataTab([1:70]));
M3.dataTab = M3.dataTab - mean(M3.dataTab([1:70]));
M4.dataTab = M4.dataTab - mean(M4.dataTab([1:70]));
% getting rid of useless samples at beginning
M1.dataTab = M1.dataTab([76:end]);
M2.dataTab = M2.dataTab([78:end]);
M3.dataTab = M3.dataTab([74:end]);
M4.dataTab = M4.dataTab([193:end]); 
% getting rid of useless samples at the end
M1.dataTab = M1.dataTab([1:780])/a_mean;
M2.dataTab = M2.dataTab([1:780])/a_mean;
M3.dataTab = M3.dataTab([1:780])/a_mean;
M4.dataTab = M4.dataTab([1:780])/a_mean; 

figure
subplot(2,2,1);
plot(M1.dataTab); hold on
plot(M2.dataTab); hold on
plot(M3.dataTab); hold on
plot(M4.dataTab); hold on
legend('M1', 'M2', 'M3', 'M4');
title("Every motor");
hold off

for i = 1:1:780
    average_thrust(i) = (M1.dataTab(i)+M2.dataTab(i)+M3.dataTab(i)+M4.dataTab(i))/4;
end

subplot(2,2,2);
plot(average_thrust);
legend('Average');
title("Average thrust of 4 motors");

subplot(2,2,3);
plot(M1.dataTab, "g"); hold on
plot(M2.dataTab, "g"); hold on
plot(M3.dataTab, "g"); hold on
plot(M4.dataTab, "g"); hold on
plot(average_thrust, "r");
legend('M1', 'M2', 'M3', 'M4', 'Average');
title("Comparison");

subplot(2,2,4);
average_omniside_thrust = (average_thrust([1:390]) + flip(average_thrust([391:end])))/2; % curve fit for this array
plot(average_omniside_thrust, "r"); hold on
plot(average_thrust([1:390]), "b"); hold on
plot(flip(average_thrust([390:end])), "m"); hold on
plot(M1.dataTab([1:390]), "g"); hold on
plot(M2.dataTab([1:390]), "g"); hold on
plot(M3.dataTab([1:390]), "g"); hold on
plot(M4.dataTab([1:390]), "g"); hold on
plot(flip(M1.dataTab([390:end])), "g"); hold on
plot(flip(M2.dataTab([390:end])), "g"); hold on
plot(flip(M3.dataTab([390:end])), "g"); hold on
plot(flip(M4.dataTab([390:end])), "g"); hold on

%pwm = linspace(1000,2000,100); %[1000:10:2000]  or  linspace(1000,2000,100)

legend('Average omniside', 'Average upward', 'Average downward');
title("Average omniside thrust");

hold off

% figure
% subplot(2,2,1);
% plot(M1.dataTab([1:370])); hold on
% plot(M2.dataTab([1:370])); hold on
% plot(M3.dataTab([1:370])); hold on
% plot(M4.dataTab([1:370])); hold on
% 
% subplot(2,2,2);
% plot(M1.dataTab([380:end])); hold on
% plot(M2.dataTab([380:end])); hold on
% plot(M3.dataTab([380:end])); hold on
% plot(M4.dataTab([380:end])); hold on
% 
% hold off
%close all

pwm = [0:1:389];        %[1:1:390]

fo = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...
               'Upper',[Inf,max(average_omniside_thrust)],...
               'StartPoint',[0 0]);
ft = fittype('a*x^2+b*x+c','problem','c','options',fo);
f = fit(pwm',average_omniside_thrust',ft,'problem',3);
% options.StartPoint = [10 1 3];
% options.Lower = [0 -Inf 0];
% ft = fittype('b*x^2+c*x+a');
% f = fit(pwm',average_omniside_thrust',ft);
%f = polyfit(pwm',average_omniside_thrust',10)
figure;
subplot(4,4,[1 2 5 6]);
plot(f,pwm',average_omniside_thrust');
grid minor
syms F

f = 0.003537*F^2 + 1.225*F;
% inversed function to use in controller
f = finverse(f);
% input F = {0; 1000};
%PWM = 950;
%PWM = PWM*390/1000;
% recomputing function
%PWM_d = 0.003537*PWM^2 + 1.225*PWM;
%pwm_d = (288230376151711744*((2038941680897209*F)/144115188075855872 + 2401/1600)^(1/2))/2038941680897209 - 1765411053929234432/10194708404486045;
% output pwm_function = {1000; 2000};
%PWM_d = PWM_d*950/1000 + 1000;

% funkcja do modelu
for PWM_d = 1000:2000
    %PWM_scaled = i*390/1000-390;
    F = 0.003537*(PWM_d*390/1000-390)^2 + 1.225*(PWM_d*390/1000-390);
    F_vec(PWM_d+1,1) = F;
end
% funkcja do sterownika
for F_d = 0:1000
    PWM = (2882303761517117440000*((3101230296644654889*F_d)/1441151880758558720000 + 3651921/16000000)^(1/2))/3101230296644654889 + 44210504476406462360/79518725554991151;
    PWM_vec(F_d+1,1) = PWM;
end
subplot(4,4,[3 7]);
plot(F_vec);
xlabel('PWM');
ylabel('Thrust');
legend('PWM to thrust');
title('PWM to thrust');
hold on 
subplot(4,4,[4 8]);
plot(PWM_vec);
xlabel('Thrust');
ylabel('PWM');
legend('Thrust to PWM');
title('Thrust to PWM');