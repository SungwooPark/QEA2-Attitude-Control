% rot321.m
% main calls function blockrot

%R = attitude_sim(0,292.5*2,0);
R = attitude_sim(50,20,100);
phi = R(:,5);
theta = R(:,6);
psi = R(:,7);

blockrot(phi, theta, psi)