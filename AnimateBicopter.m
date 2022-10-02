function  AnimateBicopter(t,x,u)
r           = x(1:2,:);
rdot        = x(3:4,:);
theta       = -x(5,:);
thetadot    = x(6,:);

c = r;
y1 = r + 0.1*[cos(theta);-sin(theta)];
y2 = r + 0.1*[-cos(theta);sin(theta)];
f = [u(1,:).*sin(theta); u(1,:).*cos(theta)]/40;

% Xmin = min([c y1 y2],[],2);
% Xmax = max([c y1 y2],[],2);

hold on
for ii = 1:length(t)

    X = [c(1,ii) y1(1,ii) y2(1,ii)];
    Y = [c(2,ii) y1(2,ii) y2(2,ii)];

    plot(X,Y,'ko-')
    
    quiver(c(1,ii), c(2,ii), f(1,ii),f(2,ii),'b')

    grid on
    axis equal
    title(num2str(t(ii)))
    pause(1e-1)
end

end