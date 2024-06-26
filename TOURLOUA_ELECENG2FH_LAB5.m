clc; %clear the command line
clear; %remove all previous variables
Epsilono=8.854e-12; %use permitivity of free space
r_upper=3.0;%upper bound of r
r_lower=2.0;%lower bound of r
r=r_lower;
phi_upper=2*pi;%upper bound of phi
phi_lower=0;%lower bound of phi
phi=phi_lower;
theta_upper=pi;%upper bound of theta
theta_lower=0;%lower bound of theta
theta=theta_lower;
Number_of_r_Steps=2000; %initialize discretization in the rho direction
dr=(r_upper-r_lower)/Number_of_r_Steps; %The r increment
Number_of_theta_Steps=2000; %initialize the discretization in the theta direction
dtheta=(theta_upper-theta_lower)/Number_of_theta_Steps; %The theta increment
Number_of_phi_Steps=2000; %initialize the phi discretization
dphi=(phi_upper-phi_lower)/Number_of_phi_Steps; %The step in the phi direction
charge_density=2e-6;%surface charge density of charged sphere
r_surface=1.0;% the radius of the charged sphere
Q_surface=(4*pi*r_surface*r_surface*charge_density);%total charge of sphere
WE=0;%the total engery stored in the region
for k=0:Number_of_r_Steps
for j=0:Number_of_theta_Steps
for i=0:Number_of_phi_Steps
D=Q_surface/(4*pi*r*r);%initializes D
E=D/Epsilono;%initializes e
dV=r*r*(sin(theta))*dr*dtheta*dphi;%volume of current element
WE=(WE+(D*E*dV));%adds the contribution of the differential volume component to WE
phi=phi+dphi;%increments phi
end %end of the i loop
phi=0;%resets phi
theta=theta+dtheta;%increments theta
end %end of the j loop
theta=0;%resets theta
r=r+dr;%increments r
end %end of the k loop
WE=WE/2;%we must account for the coefficeint of 0.5
WE


