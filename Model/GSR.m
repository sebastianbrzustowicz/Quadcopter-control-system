function output = GSR(input)
global sim_time
goal  = input(1);
time = input(2);

altitude = 0;
roll = 0;
pitch = 0;
yaw = 0;

if time >= sim_time/2 && goal~=9
switch goal
    case 1              %1 - Move forward
        roll = 5;
    case 2              %2 - Move backward
        roll = -20;
end

switch goal
    case 3              %3 - Move right
        pitch = 20;
    case 4              %4 - Move left
        pitch = -20;
end

switch goal
    case 5              %5 - Rotate CCW
        yaw = 90;
    case 6              %6 - Rotate CW
        yaw = -90;
end

switch goal
    case 7              %5 - Move to upper position
        altitude = 40;
    case 8              %6 - Move to lower position
        altitude = 5;
end
end

% if goal == 9            %custom goal
% 
% if time>0             
%         altitude = 0;
%         roll = 0;
%         pitch = 0;
%         yaw = 0;   
% end
% if time>5            
%         altitude = 4*sin(time-5);
%         roll = 4*sin(time-5);
%         pitch = 0;
%         yaw = 0;   
% end
% if time>10            
%         altitude = 4*sin(time-5);
%         roll = 4*sin(time-5);
%         pitch = 0;
%         yaw = 0;   
% end
% if time>15            
%         altitude = 4*sin(time-5);
%         roll = 4*sin(time-5);
%         pitch = 0;
%         yaw = 0;   
% end
% if time>20        
%         altitude = time*0.1;
%         roll = 0;
%         pitch = 20;
%         yaw = 0; 
% end
% if time>25           
%         altitude = time*0.1;
%         roll = 0;
%         pitch = -20;
%         yaw = 0;   
% end
% end

if goal == 9            %custom goal

if time>0             
        altitude = 0;
        roll = 50;
        pitch = 0;
        yaw = 0;   
end
if time>5            
        altitude = 0;
        roll = -50;
        pitch = 0;
        yaw = 0;   
end
if time>10            
        altitude = 0;
        roll = 0;
        pitch = 0;
        yaw = 0;   
end
if time>15            
        altitude = 0;
        roll = 0;
        pitch = 50;
        yaw = 0;   
end
if time>20        
        altitude = 0;
        roll = 0;
        pitch = -50;
        yaw = 0; 
end
if time>25           
        altitude = 0;
        roll = 0;
        pitch = 0;
        yaw = 0;   
end
end
                   
output = [altitude; roll; pitch; yaw];
end