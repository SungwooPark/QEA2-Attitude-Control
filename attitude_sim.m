function res = attitude_sim(Mx, My, Mz)
%Return a vector of angular velocity and Euler angles in x,y,z directions
%   Mx,My,Mz: Moment in x,y,z direction

    %Initial values
    init_ang_vel_x = 0;
    init_ang_vel_y = 0;
    init_ang_vel_z = 0;
    
    init_phi = 0;
    init_theta = 0.1;
    init_psi = 0.1;
    
    function res = sim(t,P)
    %ODE function
        ang_vel_x = P(1);
        ang_vel_y = P(2);
        ang_vel_z = P(3);
        
        phi = P(4);
        theta = P(5);
        psi = P(6);
        
        %Change in values
        d_ang_vel_x = Mx/3.992625;
        d_ang_vel_y = My/3.992625;
        d_ang_vel_z = Mz/3.992625;
        
        d_phi = (sin(psi)/sin(theta))*ang_vel_x + (cos(psi)/sin(theta))*ang_vel_y;
        d_theta= cos(psi)*ang_vel_x + (-sin(psi))*ang_vel_y;
        d_psi = (-cos(theta)*sin(psi)/sin(theta))*ang_vel_x + (-cos(theta)*cos(psi)/sin(theta))*ang_vel_y + ang_vel_z;
        
        res = [d_ang_vel_x; d_ang_vel_y; d_ang_vel_z; d_phi; d_theta; d_psi];
    end

    init_params = [init_ang_vel_x,init_ang_vel_y,init_ang_vel_z, init_phi, init_theta, init_psi];
    [T, R] = ode45(@sim, [0:0.01:10], init_params);
    
    %Resulting angular velocities
    wx = R(:,1);
    wy = R(:,2);
    wz = R(:,3);
    
    %Resulting Euler angles
    result_phi = R(:,4);
    result_theta = R(:,5);
    result_psi = R(:,6);
    
    clf
    hold on
    %disp(result_psi)
    %plot(T,wy);
    plot(T,result_phi);
    plot(T, result_theta);
    plot(T,result_psi);

    res = [T, R];
end

