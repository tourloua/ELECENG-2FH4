clc; %clear the command line
clear; %remove all previous variables
V=0;%initialize volume of the closed surface to 0
S1=0;%initialize the area of S1 to 0
S2=0;%initialize the area of S1 to 0
S3=0;%initialize the area of S1 to 0
S4=0;%initialize the area of S1 to 0
S5=0;%initialize the area of S1 to 0
S6=0;%initialize the area of S1 to 0
rho=2;%initialize rho to the its lower boundary
z=3;%initialize z to the its lower boundary
phi=pi/9;%initialize phi to the its lower boundary
Number_of_rho_Steps=200; %initialize the rho discretization
Number_of_phi_Steps=200;%initialize the phi discretization
Number_of_z_Steps=200;%initialize the z discretization
drho=(4-2)/Number_of_rho_Steps;%The rho increment
dphi=(pi/3-pi/9)/Number_of_phi_Steps;%The phi increment
dz=(5-3)/Number_of_z_Steps;%The z increment
%%the following routine calculates the volume of the enclosed surface
for k=1:Number_of_z_Steps
for j=1:Number_of_rho_Steps
for i=1:Number_of_phi_Steps
V=V+rho*dphi*drho*dz;%add contribution to the volume
end
rho=rho+drho;%p increases each time when z has been traveled from its lower boundary to its
upper boundary
end
rho=2;%reset rho to its lower boundary
end


%%the following routine calculates the area of S1 and S2
rho1=2;%radius of S1
rho2=4;%radius of s2
for k=1:Number_of_z_Steps
for i=1:Number_of_phi_Steps
S1=S1+rho1*dphi*dz;%get contribution to the the area of S1
S2=S2+rho2*dphi*dz;%get contribution to the the area of S2
end
end
%%the following routing calculate the area of S3 and S4
rho=2;%reset rho to it's lower boundaty
for j=1:Number_of_rho_Steps
for i=1:Number_of_phi_Steps
S3=S3+rho*dphi*drho;%get contribution to the the area of S3
end
rho=rho+drho;%p increases each time when phi has been traveled from it's lower boundary to it's
upper boundary
end
S4=S3;%the area of S4 is equal to the area of S3
%%the following routing calculate the area of S5 and S6
for k=1:Number_of_z_Steps
for j=1:Number_of_rho_Steps
S5=S5+dz*drho;%get contribution to the the area of S3
end
end
S6=S5;%the area of S6 is equal to the area of S6
S=S1+S2+S3+S4+S5+S6;%the area of the enclosed surface
