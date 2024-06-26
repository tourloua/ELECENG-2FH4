%{
BIOT-SAVART WAY (REALLY SLOW+INACCURATE)
clc; % Clear the command window
clear; % Clear all variables
current=5;
NumberOfTurns = 200; % Number of turns of the toroid
Radius = 0.02; % Central radius of toroid
loop_radius=0.005;%radius of each loop
theta_min = 0;
theta_max = 2*pi;
slices = 20000; % Number of slices, any big number, bigger is more accurate, but slower to compute
radial_coordinates = zeros(3, slices+1);%vector holding the coordinates of each point on the toroid, and the
%distance from the origin to each point
points_per_turn=slices/NumberOfTurns;%number of points on each turn of the torus
%loop_radius*cos((mod(m,(slices/NumberOfTurns)))/(slices/NumberOfTurns)*2*pi)
%is the radial offset of each point on the toroid
%this for loop flinds the x,y and z coordinates for every point in the toroid
for m = 1:slices
    thistheta = theta_min + m * ((theta_max - theta_min) / slices);
    radial_coordinates(1, m) = (Radius+loop_radius*cos((mod(m,(slices/NumberOfTurns)))/(slices/NumberOfTurns)*2*pi))*cos(thistheta);%x coordinate of each point on toroid
    radial_coordinates(2, m) = (Radius+loop_radius*cos((mod(m,(slices/NumberOfTurns)))/(slices/NumberOfTurns)*2*pi))*sin(thistheta);%y coordinate of each point on toroid
    radial_coordinates(3, m)=loop_radius*sin((mod(m,(slices/NumberOfTurns)))/(slices/NumberOfTurns)*2*pi);%z coordinate of each point on the toroid. Values should 
    %repeat every slices/NumberofTurns points
end
radial_coordinates(1, slices+1)=radial_coordinates(1, 1);%needed for current vectors
radial_coordinates(2, slices+1)=radial_coordinates(2, 1);
radial_coordinates(3, slices+1)=radial_coordinates(3, 1);
current_vectors=zeros(3, slices);
for n = 1:slices
    current_vectors(1,n)=radial_coordinates(1, n)-radial_coordinates(1, n+1);
    current_vectors(2,n)=radial_coordinates(2, n)-radial_coordinates(2, n+1);
    current_vectors(3,n)=radial_coordinates(3, n)-radial_coordinates(3, n+1);
end%current vecctors now populated with the current vector at each point
current_vectors=transpose(current_vectors);
radial_coordinates=transpose(radial_coordinates);
xy_plane_points=zeros(3,41*41);
for i=1:41*41
    xy_plane_points(1,i)=mod((i-1),41)*0.002-0.04;
    xy_plane_points(2,i)=round((i-21)/41)*0.002-0.04;
end%the x and y coordinates for each point on the direction field
xy_plane_points=transpose(xy_plane_points);
%it's just biot savart's law at each point in the x-y plane
B_vectors=zeros(41*41,3);
for k=1:41*41
    for j=1:slices
        B_vectors(k,[1 2 3])=B_vectors(k,[1 2 3])+current*cross(current_vectors(j,[1 2 3]),(xy_plane_points(k,[1 2 3])-radial_coordinates(j,[1 2 3])))/(4*pi*(norm(xy_plane_points(k,[1 2 3])-radial_coordinates(j,[1 2 3])))^3);
end
end
B_vectors(:,3)=[];%we don't care about the z coordinates of our magnetic field since we're plotting on the x-y plane
xy_plane_points(:,3)=[];
% Plot the direction field
quiver(xy_plane_points(:,1), xy_plane_points(:,2), B_vectors(:,1), B_vectors(:,2));
% Add labels and title
xlabel('x');
ylabel('y');
title('Direction Field');

%}

%Ampere's law way

clc;
clear;
theta_min = 0;%fields will rotate CCW
theta_max = -2*pi; %toroids are 360 degrees
x_points = 40; %initialize square viewing area
y_points = x_points;
x_max = 0.04; 
x_min = -0.04;
y_max = x_max; 
y_min = x_min;
loops = 200; % # turns in the toroid
avg_rad = (0.015 + 0.025) / 2; % Average radius
loop_radius = (0.025 - 0.015) / 2; %radius of an individual loop
slices = 10000; % # of infinitesmally small slices of the loop 
x_step = (x_max - x_min) / (x_points - 1); % X step size
y_step = (y_max - y_min) / (y_points - 1); % Y step size
angles = linspace(theta_min, theta_max, (slices + 1))';
x_coords = (avg_rad + loop_radius * cos(loops * angles)) .* cos(angles);
y_coords = (loop_radius * cos(loops * angles) + avg_rad) .* sin(angles);
z_coords = loop_radius * sin(loops * angles); % Calculating coordinates
current = 5; %5A flows through the toroid
Z = 0; % we want our direction field to be on the x-y plane
[XGrid, YGrid] = meshgrid(x_min:x_step:x_max, y_min:y_step:y_max); 
x_comp_field = zeros(x_points, y_points); % Magnetic field x-component
y_comp_field = zeros(x_points, y_points); % Magnetic field y-component
for i = 1:x_points
    for j = 1:y_points
        this_x = XGrid(i, j); % this X coordinate
        this_y = YGrid(i, j); % this Y coordinate
        refpoint = [this_x, this_y, Z]; % Observation point vector
        for h = 1:slices
            first_x = x_coords(h);
            end_x = x_coords(h + 1);
            first_y = y_coords(h);
            end_y = y_coords(h + 1);
            first_z = z_coords(h);
            end_z = z_coords(h + 1);
            dl = [end_x - first_x, end_y - first_y, end_z - first_z];
            center_point = 0.5 * [first_x + end_x, first_y + end_y, first_z + end_z];
            R = refpoint - center_point;
            mag_R = norm(R);
            R_unit = R / mag_R;
            % Element magnetic field contribution
            dH = (current / (4*pi*mag_R^2)) * cross(dl, R_unit);
            x_comp_field(i, j) = x_comp_field(i, j) + dH(1);%x and y components of the field
            y_comp_field(i, j) = y_comp_field(i, j) + dH(2);
        end
    end
end
quiver(XGrid, YGrid, x_comp_field, y_comp_field);
xlabel('X (m)');
ylabel('Y (m)');
title('Direction Field');