clc; %clear the command line
clear; %remove all previous variables
Epsilono=8.854e-12; %use permittivity of air
phi=0;
rho=0;
D=2e-6; %the surface charge density
P=[0 0 1]; %the position of the observation point
E=[0,0,0];
Number_of_rho_Steps=5000;%initialize discretization in the rho direction
Number_of_phi_Steps=5000;%initialize discretization in %the phi direction
rho_lower=0; %the lower boundary of rho
rho_upper=1; %the upper boundary of rho
phi_lower=0; %the lower boundary of phi
phi_upper=(2*pi); %the upper boundary of phi
drho=(rho_upper- rho_lower)/Number_of_rho_Steps; %the rho increment or the width of a grid
dphi=(phi_upper- phi_lower)/Number_of_phi_Steps; %The phi increment or the length of a grid
for j=1: Number_of_rho_Steps
for i=1: Number_of_phi_Steps
RMag=sqrt((rho*rho)+(1)); % magnitude of vector from the differential surface element to point P
ds=drho*dphi*rho; %the area of a single grid
dQ=D*ds; % the charge on a single grid
E(1)=E(1)+(dQ/(4*Epsilono*pi* RMag ^3))*(rho*cos(phi));% get contribution to the E field in x direction
E(2)=E(2)+(dQ/(4*Epsilono*pi* RMag ^3))*(rho*sin(phi));% get contribution to the E field in y direction
E(3)=E(3)+(dQ/(4*Epsilono*pi* RMag ^3)); % get contribution to the E field in z direction
phi=phi+dphi;%increment phi
end
rho=rho+drho; %increment rho
end
E