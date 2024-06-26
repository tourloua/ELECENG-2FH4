%% Screen Init
clc;
clear;

%% Var Init
thetaMin = pi;
thetaMax = -pi; % Setting angular bounds

xPoints = 40; % Points along the x-axis
yPoints = 40; % Points along the y-axis
minX = -0.04;
maxX = 0.04; % X-axis bounds
minY = -0.04;
maxY = 0.04; % Y-axis bounds

spiralTurns = 200; % Total spiral turns
avgRadius = (0.015 + 0.025) / 2; % Average radius
thickness = (0.025 - 0.015) / 2; % Thickness of the coil
segmentCount = 10000; % Number of line segments

stepX = (maxX - minX) / (xPoints - 1); % X step size
stepY = (maxY - minY) / (yPoints - 1); % Y step size

thetaVals = linspace(thetaMin, thetaMax, (segmentCount + 1))';
xCoords = (avgRadius + thickness * cos(spiralTurns * thetaVals)) .* cos(thetaVals);
yCoords = (thickness * cos(spiralTurns * thetaVals) + avgRadius) .* sin(thetaVals);
zCoords = thickness * sin(spiralTurns * thetaVals); % Calculating coordinates

currentI = 5; % Electric current
observationZ = 0; % Z-coordinate for observation plane

[XGrid, YGrid] = meshgrid(minX:stepX:maxX, minY:stepY:maxY); % Grid generation
fieldX = zeros(xPoints, yPoints); % Magnetic field X-component
fieldY = zeros(xPoints, yPoints); % Magnetic field Y-component

%% Magnetic Field Calculations
for xIndex = 1:xPoints
    for yIndex = 1:yPoints
        currentX = XGrid(xIndex, yIndex); % Current X coordinate
        currentY = YGrid(xIndex, yIndex); % Current Y coordinate
        obsPoint = [currentX, currentY, observationZ]; % Observation point vector
        
        for segment = 1:segmentCount
            % Segment start and end coordinates
            startX = xCoords(segment);
            endX = xCoords(segment + 1);
            startY = yCoords(segment);
            endY = yCoords(segment + 1);
            startZ = zCoords(segment);
            endZ = zCoords(segment + 1);
            
            % Segment vector and calculations
            dl = [endX - startX, endY - startY, endZ - startZ];
            centerPos = 0.5 * [startX + endX, startY + endY, startZ + endZ];
            R = obsPoint - centerPos;
            distR = norm(R);
            R_unit = R / distR;
            
            % Element magnetic field contribution
            dH = (currentI / (4 * pi * distR^2)) * cross(dl, R_unit);
            fieldX(xIndex, yIndex) = fieldX(xIndex, yIndex) + dH(1);
            fieldY(xIndex, yIndex) = fieldY(xIndex, yIndex) + dH(2);
        end
    end
end

%% Plot of Magnetic Field
quiver(XGrid, YGrid, fieldX, fieldY);
xlabel('X (m)');
ylabel('Y (m)');