clc
clear all
close all

m = 2;
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

x_r = rand(2,1)


J = 3;
At = [0 1; 0 0];
Bt = [0;1/J];
Ct = [1 0];
Kt = -place(At,Bt,[-30 -20]);
eig(At+Bt*Kt);

Ata = [At zeros(2,1); -Ct zeros(1) ];
Bta = [Bt; zeros(1)];

Kta = -place(Ata,Bta,[-30 -35 -40]);
eig(Ata+Bta*Kta)

Ktx = Kta(:,1:2);
Ktq = Kta(:,3);

theta_r = rand(1,1)

%%
I12 = eye(12);
C12_OL = I12([1 3 4 6],:);
C12_IL = I12([8 11],:);





















