clc; %clear the command line
clear; %remove all previous variables
V=0;%initialize volume of the closed surface to 0
r=0;%initialize r to the its lower boundary
phi=(pi/4);%initialize phi to the its lower boundary
theta=(pi/4);%initialize theta to the its lower boundary
Number_of_r_Steps=500; %initialize the r discretization
Number_of_phi_Steps=500;%initialize the phi discretization
Number_of_theta_Steps=500;%initialize the theta discretization
dr=(2-0)/Number_of_r_Steps;%The r increment
dphi=((pi/2)-(pi/4))/Number_of_phi_Steps;%The phi increment
dtheta=((pi/2)-(pi/4))/Number_of_theta_Steps;%The theta increment
%%the following routine calculates the volume of the enclosed surface
for k=1:Number_of_r_Steps
    for j=1:Number_of_phi_Steps
        for i=1:Number_of_theta_Steps
            V=V+dr*r*r*dtheta*dphi*sin(theta);%add contribution to the volume
            theta=theta+dtheta;%increment theta
        end
        theta=pi/4;%reset theta to its lower bound
        phi=phi+dphi;%increment phi
    end
    phi=pi/4;%reset phi to its lower bound
    r=r+dr;%incremenet r
end


%Now for the area




S1=0;%initialize the area of S1 to 0
S2=0;%initialize the area of S2 to 0
S3=0;%initialize the area of S3 to 0
S4=0;%initialize the area of S4 to 0
S5=0;%initialize the area of S5 to 0
Area=0;%initialize the area to 0


%First up are the two vertical faces
%In both cases, the area is independent of phi. r and theta vary



r=0;%initialize r to the its lower boundary
theta=(pi/4);%initialize theta to the its lower boundary

Number_of_r_Steps=500; %initialize the r discretization
Number_of_theta_Steps=500;%initialize the theta discretization
dr=(2-0)/Number_of_r_Steps;%The r increment
dtheta=((pi/2)-(pi/4))/Number_of_theta_Steps;%The theta increment

for k=1:Number_of_r_Steps
    for j=1:Number_of_theta_Steps
        S1=S1+r*dtheta*dr;
        theta=theta+dtheta;%increment theta
        end
    theta=pi/4;%reset theta to its lower bound
    r=r+dr;%increment r
    end
S2=S1;%no other face is equal in area to any other face

%next is the top upwards sloping face
%here theta=45 degrees. r and phi vary


r=0;%initialize r to the its lower boundary
theta=(pi/4);%initialize theta
phi=pi/4;%initialize phi to the its lower boundary

Number_of_r_Steps=500; %initialize the r discretization
Number_of_phi_Steps=500;%initialize the theta discretization
dr=(2-0)/Number_of_r_Steps;%The r increment
dphi=((pi/2)-(pi/4))/Number_of_theta_Steps;%The phi increment

for k=1:Number_of_r_Steps
    for j=1:Number_of_phi_Steps
        S3=S3+r*dphi*dr*sin(theta);
        phi=phi+dphi;%increment phi
        end
    phi=pi/4;%reset phi to its lower bound
    r=r+dr;%increment r
end



%Now let's do the face that is on the xy-plane

r=0;%initialize r to the its lower boundary
theta=(pi/2);%initialize theta
phi=pi/4;%initialize phi to the its lower boundary

Number_of_r_Steps=500; %initialize the r discretization
Number_of_phi_Steps=500;%initialize the theta discretization
dr=(2-0)/Number_of_r_Steps;%The r increment
dphi=((pi/2)-(pi/4))/Number_of_theta_Steps;%The phi increment

for k=1:Number_of_r_Steps
    for j=1:Number_of_phi_Steps
        S4=S4+r*dphi*dr*sin(theta);
        phi=phi+dphi;%increment phi
        end
    phi=pi/4;%reset phi to its lower bound
    r=r+dr;%increment r
    end



%Now for the outermost face

r=2;%initialize r
theta=(pi/4);%initialize theta to the its lower boundary
phi=pi/4;%initialize phi to the its lower boundary

Number_of_r_Steps=500; %initialize the r discretization
Number_of_phi_Steps=500;%initialize the theta discretization
dphi=((pi/2)-(pi/4))/Number_of_phi_Steps;%The phi increment
dtheta=((pi/2)-(pi/4))/Number_of_theta_Steps;%The phi increment

for k=1:Number_of_phi_Steps
    for j=1:Number_of_theta_Steps
        S5=S5+r*r*dphi*dtheta*sin(theta);
        theta=theta+dtheta;%increment theta
        end
    theta=pi/4;%reset theta to its lower bound
    phi=phi+dphi;%increment phi
    end
%Now for total area

Area=S1+S2+S3+S4+S5;

S1,S2,S3,S4,S5
V
Area

%Surface area is same deal but remeber to change
%differential surface element on different faces
