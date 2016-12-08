% Code from Christopher Lee, Associate Prof. of Mechanical Engineering,
% Olin College of Engineering

% blockrot: function that rotates and animated block
% Each set of Euler Angles is animated with respect to the INITIAL orientation
% Each subsequent set is NOT animated with respect to the last orientation state

function [M]=blockrot(phin, thetan,psin)

% define sides of rectangular solid
A = 10;
B = 10;
C = 10;
a=A/2;
b=B/2;
c=C/2;
% switch signs on angles: rotating ref frames compared to rotating points
psi   = -psin;
theta = -thetan;
phi   =  -phin;

% Vertices of the rectangular solid with the a center of mass at the origin of
% the inertial basis. 

v1=[a   b -c]'; %bottom right back
v2=[a  -b -c]'; %bottom right front
v3=[-a -b -c]'; %bottom left front
v4=[-a  b -c]'; %bottom left back
v5=[a   b c]';  %top right back
v6=[a  -b c]';  %top right front
v7=[-a -b c]';  %top left front
v8=[-a  b c]';  %top left back

V=[v1 v2 v3 v4 v5 v6 v7 v8];


    for i = 1:length(psi)

% Define rotation matrices here %%%%%%%%%          
% first rotation, R1, is phi about z-axis (3-yaw)
R1 = [cos(phi(i)) sin(phi(i)) 0; -sin(phi(i)) cos(phi(i)) 0; 0 0 1];
% second rotation, R2, is theta about x'-axis, (1-roll)
R2 = [1 0 0; 0 cos(theta(i)) sin(theta(i)); 0 -sin(theta(i)) cos(theta(i))];
% third rotation, R3, is psi about z''-axis, (3-yaw) 
R3= [cos(psi(i)) sin(psi(i)) 0; -sin(psi(i)) cos(psi(i)) 0; 0 0 1];

R321 = R3*R2*R1;

    E=R321*V;
    
    e1=E(:,1);
    e2=E(:,2);
    e3=E(:,3);
    e4=E(:,4);
    e5=E(:,5);
    e6=E(:,6);
    e7=E(:,7);
    e8=E(:,8);
    
    %Construct polygons from four vertices for each set of faces
    %bottom & top
    top = [ e5 e6 e7 e8];
    bot = [ e1 e2 e3 e4]; 
    %left & right
    lef = [e3 e4 e8 e7];
    rig = [e1 e2 e6 e5];
    %front & back
    fro = [e2 e3 e7 e6];
    bac = [e1 e4 e8 e5];
    
    hold off
    fill3(fro(1,:),fro(2,:),fro(3,:),'r','FaceAlpha',1)
    hold on
    fill3(bac(1,:),bac(2,:),bac(3,:),'y','FaceAlpha',1)
    fill3(rig(1,:),rig(2,:),rig(3,:),'g','FaceAlpha',1)
    fill3(lef(1,:),lef(2,:),lef(3,:),'b','FaceAlpha',1)
    fill3(bot(1,:),bot(2,:),bot(3,:),'k','FaceAlpha',1)
    fill3(top(1,:),top(2,:),top(3,:),'c','FaceAlpha',1)

    title(i);
    dim=sqrt(A^2+B^2+C^2)/2;
    axis([-15 15 -15 15 -15 15]);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    M(i)=getframe;
    
    pause %hit any key to continue; or pause(5)-pause for 5 sec.
end
