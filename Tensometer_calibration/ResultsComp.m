clear, close all

waga307g = load('307g.mat');
waga460g = load('460g.mat');
waga620g = load('620g.mat');
waga0g = load('bez_odważników.mat');

figure
plot(waga0g.dataTab);
hold on
plot(waga307g.dataTab);
hold on
plot(waga460g.dataTab);
hold on
plot(waga620g.dataTab);
legend('0g', '307g', '460g', '620g');
hold off

avg0g = mean(waga0g.dataTab);
avg307g = mean(waga307g.dataTab);
avg460g = mean(waga460g.dataTab);
avg620g = mean(waga620g.dataTab);

%plot();

a1 = (avg620g - avg0g)/620;
a2 = (avg460g - avg0g)/460;
a3 = (avg307g - avg0g)/307;
a4 = (avg620g - avg307g)/313;

a_mean = mean([a1, a2, a3, a4]) %a_mean = 1.6919;

%Test_triangle = load('Test_triangle.mat');
%matlab = load('matlab.mat');

%matlab.dataTab = matlab.dataTab - avg0g;
%Test_triangle.dataTab = Test_triangle.dataTab - avg0g;
%figure
%plot(matlab.dataTab)
%figure
%plot(Test_triangle.dataTab)