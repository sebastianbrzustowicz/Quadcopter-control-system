clear, close all, warning('off')

global kf kM Ix Iy Iz l m g kt kr PWM_min PWM_max F_min F_max init sim_time step_size roll pitch yaw gain
kf = 3.13e-5;             %Thrust coefficient
kM = 7.5e-7;             %Moment coefficient
Ix = 28.8e-3;
Iy = 28.8e-3;
Iz = 26e-2;
l = 0.22;                           %distance between motor and center of quadcopter
m = 1.40;
g = 9.81;
kt = 2*[0.1,0,0;0,0.1,0;0,0,0.1];
kr = [0.1,0,0;0,0.1,0;0,0,0.1];
PWM_min = 1000;
PWM_max = 2000;
F_min = 0;
F_max = 9.32;

smallest_number = eps(0.1);

init.x = 0;
init.y = 0;
init.z = 0;
init.phi = smallest_number;
init.theta = smallest_number;
init.psi = 0;
init.dx = 0;
init.dy = 0;
init.dz = 0;
init.p = 0;
init.q = 0;
init.r = 0;

% init.x = 0;
% init.y = 0;
% init.z = 70;
% init.phi = 70;
% init.theta = eps(1);
% init.psi = 0;
% init.dx = 0;
% init.dy = 30;
% init.dz = -35;
% init.p = -20;
% init.q = 0;
% init.r = 0;

gain.kp_a = 2000;      %80
gain.kd_a = 1700;     %120
gain.ki_a = 900;      %10
gain.kp_r = 10;      %10
gain.kd_r = 18;      %12
gain.ki_r = 0;       %0
gain.kp_p = 10;      %10
gain.kd_p = 18;      %12
gain.ki_p = 0;       %0
gain.kp_y = 0;
gain.kd_y = 0;
gain.ki_y = 0;

roll = init.phi;
pitch = init.theta;
yaw = init.psi;

sim_time = 30;
step_size = 0.1;

data = sim("Quadcopter.slx");

%Animated_plot(init, data);
%Animated_orientation_plot(init, data);
%Trajectory_plot(init, data);
Plot_altitude_data(init, data);
Plot_attitude_data(init, data);