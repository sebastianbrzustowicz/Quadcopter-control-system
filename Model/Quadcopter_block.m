function output = Quadcopter(input)
F1 = input(1);
F2 = input(2);
F3 = input(3);
F4 = input(4);

global kf kM Ix Iy Iz I l m g kt kr

U1 = F1+F2+F3+F4;                   %Altitude
U2 = l*(-F1-F2+F3+F4);              %Phi    (Roll)
U3 = l*(F1-F2-F3+F4);               %Theta  (Pitch)
U4 = kM*(F1-F2+F3-F4);              %Psi    (Yaw)
% U1 = 40; %13.734 dla masy 1.4
% U2 = 0;
% U3 = 0;
% U4 = 0;  %0.000000000000000001;

x = input(5);
y = input(6);
z = input(7);
phi = input(8);
theta = input(9);
psi = input(10);
dx = input(11);
dy = input(12);
dz = input(13);
p = input(14);
q = input(15);
r = input(16);

%position
ddx = dx*kt(1,1)-(sind(phi)*sind(psi)+cosd(phi)*cosd(psi)*sind(theta))*(U1/m);
ddy = dy*kt(2,2)-(sind(phi)*cosd(psi)-cosd(phi)*sind(psi)*sind(theta))*(U1/m);
ddz = -dz*kt(3,3)-g+cosd(theta)*cosd(phi)*(U1/m);
%orientation
dphi = p+r*(cosd(phi)*tand(theta))+q*(sind(phi)*tand(theta));
dtheta = q*(cosd(phi))-r*(sind(phi));
dpsi = r*(cosd(phi)/tand(theta))+q*(sind(phi)/cosd(theta));
%angular velocity
dp = ((Iz - Iy)/Ix)*q*r + (U2/Ix);
dq = ((Ix - Iz)/Iy)*p*r + (U3/Iy);
dr = ((Iy - Ix)/Iz)*p*q + (U4/Iz);

%ground limit
%if z <= 0 
%    z = 0;
%    dz = 0;
%    ddz = 0;
%end


output = [ddx,ddy,ddz,dphi,dtheta,dpsi,dp,dq,dr];
end