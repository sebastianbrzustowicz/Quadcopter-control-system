function output = Animated_plot(init, data)

% STL scale factor
Scale_factor = max(max([abs(data.position(:,1)) abs(data.position(:,2)) abs(data.position(:,3))]))/1200;

% Setting up the Plot
figure; hold on;
title(sprintf('Trajectory\nTime: %0.2f sec', data.time(1)), 'Interpreter', 'Latex');
xlabel('x', 'Interpreter', 'Latex')
ylabel('y', 'Interpreter', 'Latex')
zlabel('z', 'Interpreter', 'Latex')
grid minor  % Adding grid lines
axis equal  % Equal axis aspect ratio
%set(gcf, 'Position', get(0, 'Screensize'))
title(sprintf('Animated plot'), 'Interpreter', 'Latex')
view(-37.5,30);  % Setting viewing angle

% Scene
h = fsurf(0,'g');hold on;
set(h,'edgecolor','none','facecolor',[.1 .9 .1]);
alpha 0.3;


% Create file name variable
filename = 'animation.gif';
% Plotting with no color to set axis limits
%plot3(x,y,z,'Color','none');
plot3(data.position(:,1),data.position(:,2),data.position(:,3),'Color','none')
% Plotting the first iteration
p = plot3(data.position(:,1),data.position(:,2),data.position(:,3),'b');
m = scatter3(data.position(:,1),data.position(:,2),data.position(:,3),'filled','b');

q_init = quaternion([init.psi init.theta init.phi],"eulerd","ZYX","frame");
position_init = [init.x init.y init.z];
q = poseplot(q_init,position_init,MeshFileName="multirotor.stl",ScaleFactor=Scale_factor);

% Iterating through the length of the time array
for k = 1:size(data.position,1)
    % Updating the line
    p.XData = data.position(1:k,1);
    p.YData = data.position(1:k,2);
    p.ZData = data.position(1:k,3);
    % Updating the point
    m.XData = data.position(k,1);
    m.YData = data.position(k,2);
    m.ZData = data.position(k,3);
    % Updating the poseplot
    q.Orientation = quaternion([data.orientation(k,3) data.orientation(k,2) data.orientation(k,1)],"eulerd","ZYX","frame");
    q.Position = [data.position(k,1) data.position(k,2) data.position(k,3)];
    % Updating the title
    title(sprintf('Trajectory\nTime: %0.2f sec', data.time(k)),...
    'Interpreter','Latex');
    % Delay
    %pause(0.01)
    % Saving the figure
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,...
        'DelayTime',0.1);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append',...
        'DelayTime',0.1);
    end
end
end