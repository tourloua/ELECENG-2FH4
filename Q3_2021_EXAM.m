clc;
clear;
multiplier=1e-6;
Q_meter=0;
phi_max=2*pi;
phi_min=0;
d_phi=(phi_max-phi_min)/2000;
z_min=0;
z_max=1;
dz=(z_max-z_min)/2000;
rho_min=0.005;
rho_max=0.01;
d_rho=(rho_max-rho_min)/2000;
rho=rho_min;
phi=phi_min;
z=z_min;
for i=1:2000
    for j=1:2000
        for k=1:2000
            Q_meter=Q_meter+((0.0001-rho^2)*rho*d_phi*dz*d_rho);
            z=z+dz;
        end
        rho=rho+d_rho;
        z=z_min;
    end
    rho=rho_min;
    phi=phi+d_phi;
end
Q_meter=Q_meter*multiplier;
E=Q_meter/(2*pi*8.854e-12*sqrt(0.015^2+0.05^2));
E_x=((E*0.015)/sqrt(0.015^2+0.05^2));
E_y=((E*0.05)/sqrt(0.015^2+0.05^2));