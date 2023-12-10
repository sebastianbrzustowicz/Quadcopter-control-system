function output = Plot_altitude_data(init, data)

Scale_factor = max(max([abs(data.position(:,1)) abs(data.position(:,2)) abs(data.position(:,3))]))/1200;

figure;
subplot(2,6,[1 2 3]);
plot3(data.position(:,1),data.position(:,2),data.position(:,3))
hold on

q_init = quaternion([init.psi init.theta init.phi],"eulerd","ZYX","frame");
position_init = [init.x init.y init.z];
poseplot(q_init,position_init,MeshFileName="multirotor.stl",ScaleFactor=Scale_factor)
xlabel('x', 'Interpreter', 'Latex')
ylabel('y', 'Interpreter', 'Latex')
zlabel('z', 'Interpreter', 'Latex')
hold on

for i = round(size(data.position,1)/10):round(size(data.position,1)/10):size(data.position,1)
    %disp(i);
    q_middle = quaternion([data.orientation(i,3) data.orientation(i,2) data.orientation(i,1)],"eulerd","ZYX","frame");
    position_middle = [data.position(i,1) data.position(i,2) data.position(i,3)];
    poseplot(q_middle,position_middle,MeshFileName="multirotor.stl",ScaleFactor=Scale_factor)
    xlabel('x', 'Interpreter', 'Latex')
    ylabel('y', 'Interpreter', 'Latex')
    zlabel('z', 'Interpreter', 'Latex')
    hold on
end

q_end = quaternion([data.orientation(end,3) data.orientation(end,2) data.orientation(end,1)],"eulerd","ZYX","frame");
position_end = [data.position(end,1) data.position(end,2) data.position(end,3)];
poseplot(q_end,position_end,MeshFileName="multirotor.stl",ScaleFactor=Scale_factor)
xlabel('X')
ylabel('Y')
zlabel('Z')

grid on
axis equal
title(sprintf('Trajectory'), 'Interpreter', 'Latex')
hold off

%altitude
subplot(2,6,[4 5 6]);
plot(data.position(:,3),"r")
hold on
plot(data.signals_d(:,1),"g")
hold on
xlabel('sample')
ylabel('Altitude (m)')
grid on
title(sprintf('Altitude'), 'Interpreter', 'Latex')
legend('Altitude', 'Desired altitude')
hold off

%PWM
subplot(2,6,[7 8]);
plot(data.pwm(:,1),"r")
hold on
plot(data.pwm(:,2),"g")
hold on
plot(data.pwm(:,3),"b")
hold on
plot(data.pwm(:,4),"m")
hold on
xlabel('sample')
ylabel('PWM')
grid on
title(sprintf('PWM'), 'Interpreter', 'Latex')
legend('PWM1', 'PWM2', 'PWM3', 'PWM4')
hold off

%error
subplot(2,6,[9 10]);
plot(data.signals_d(:,1)-data.position(:,3),"r")
hold on
xlabel('sample')
ylabel('Altitude error (m)')
grid on
title(sprintf('Altitude error'), 'Interpreter', 'Latex')
legend('Altitude error')
hold off

%integral criterion
subplot(2,6,[11 12]);
plot(cumsum(abs(data.signals_d(:,1)-data.position(:,3))),"r")
hold on
xlabel('sample')
ylabel('Altitude integral criterion (m)')
grid on
title(sprintf('Altitude integral criterion - absolute sum'), 'Interpreter', 'Latex')
legend('integral criterion')
set(gcf, 'Position', get(0, 'Screensize'))
hold off
end