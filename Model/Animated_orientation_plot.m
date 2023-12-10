function output = Animated_orientation_plot(init, data)
%poseplot orientation
figure; hold on;
Scale_factor = max(max([abs(data.position(:,1)) abs(data.position(:,2)) abs(data.position(:,3))]))/1200;
xlabel('X', 'Interpreter', 'Latex')
ylabel('Y', 'Interpreter', 'Latex')
zlabel('Z', 'Interpreter', 'Latex')
grid minor  % Adding grid lines
axis equal  % Equal axis aspect ratio
%set(gcf, 'Position', get(0, 'Screensize'))
view(-37.5,30);  % Setting viewing angle
filename = 'animation_orientation.gif';
q_init = quaternion([init.psi init.theta init.phi],"eulerd","zyx","frame");
position_init = [0 0 0];
q = poseplot(q_init,position_init,MeshFileName="multirotor.stl",ScaleFactor=Scale_factor);

%set(gca,'Zdir','reverse')

for k = 1:size(data.position,1)
    q.Orientation = quaternion([data.orientation(k,3) data.orientation(k,2) data.orientation(k,1)],"eulerd","zyx","frame");
    q.Position = [data.position(k,1) data.position(k,2) data.position(k,3)];
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
hold off

end