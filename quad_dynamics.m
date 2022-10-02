function [xdot] = quad_dynamics(t,x,u)

m = 1;
J = blkdiag(10,10,1);

r = x(1:3,1);
v = x(4:6,1);

Eul_Angles = x(7:9,1);
omega_QE = x(10:12,1);

force = u(1);
moment = u(2:4);

g = [0;0;10];

xdot = x*0;

Phi     = Eul_Angles(1);
Theta   = Eul_Angles(2);
Psi     = Eul_Angles(3);


[O3psi, O2theta, O1phi] = orientation_matrices(Phi, Theta, Psi);

xdot(1:3,1) = v;
xdot(4:6,1) = g + force/m*transpose(O3psi) * transpose(O2theta) * transpose(O1phi)*[0;0;1];

xdot(7:9,1) = S_Phi_Theta_inv(Phi,Theta)*omega_QE;
xdot(10:12,1) = J\(-cross(omega_QE,J*omega_QE)+moment);


end

function S = S_Phi_Theta_inv(Phi,Theta)
S = [1 sin(Phi)*tan(Theta) cos(Phi)*tan(Theta);
    0 cos(Phi) -sin(Phi);
    0 sin(Phi)*sec(Theta) cos(Phi)*sec(Theta)];
end

function [O3psi, O2theta, O1phi] = orientation_matrices(phi, theta, psi);
O3psi = [cos(psi) sin(psi) 0;
    -sin(psi) cos(psi) 0;
    0 0 1];
O2theta = [cos(theta) 0 -sin(theta);
    0 1 0
    sin(theta) 0 cos(theta)];
O1phi = [1 0 0
    0 cos(phi) sin(phi);
    0 -sin(phi) cos(phi) ;];
end


