clc;
clear;
mu_not=4*pi*10^(-7);
R_big=0.03;
h=0.02;
B=(R_big^2)/(2*(R_big^2+h^2)^(3/2));
rho_min=0;
rho_max=0.01;
phi_min=0;
phi_max=2*pi;
B=B*mu_not;
psi=0;
d_rho=(rho_max-rho_min)/1000;
d_phi=(phi_max-phi_min)/1000;
rho=rho_min;
phi=phi_min;
for i=1:1000
    for j=1:1000
        psi=psi+B*rho*d_rho*d_phi;
        phi=phi+d_phi;
    end
    phi=0;
    rho=rho+d_rho;
end
m=psi;

