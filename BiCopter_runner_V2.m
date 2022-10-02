clc
clear all
close all

% randn('state',1)
rand('state',1)

m = 2;
J = 3;
% inertia = [m J J J]';

x_r     = randn(2,1)*10 % Command
theta_r = rand(1,1); % Inner loop test command
%% Outer loop pole placement
A = [zeros(2) eye(2); zeros(2,4)];
B = [zeros(2); eye(2)/m];
C = [eye(2) zeros(2)];
K = -place(A,B,[-1 -2 -3 -4]);
eig(A+B*K);

Aa = [A zeros(4,2); -C zeros(2) ];
Ba = [B; zeros(2)];

Ka = -place(Aa,Ba,[-1 -2 -3 -4 -5 -6]);
eig(Aa+Ba*Ka);

Kx = Ka(:,1:4);
Kq = Ka(:,5:6);

%% Inner loop pole placement
At = [0 1; 0 0];
Bt = [0;1/J];
Ct = [1 0];
Kt = -place(At,Bt,[-30 -20]);
eig(At+Bt*Kt);

Ata = [At zeros(2,1); -Ct zeros(1) ];
Bta = [Bt; zeros(1)];

Kta = -place(Ata,Bta,[-30 -35 -40]/1);
eig(Ata+Bta*Kta)

Ktx = Kta(:,1:2);
Ktq = Kta(:,3);


%% Split state for outer and inner loop
I12 = eye(6);
C12_OL = I12(1:4,:);
C12_IL = I12(5:6,:);

%% Simulate Simulink Model
simout = sim("BiCopter_Control_V4.slx");

%% Plot data
t       = simout.u.Time;
u       = simout.u.Data;
x       = squeeze(simout.x.Data);

AnimateBicopter(t,x,u')


















