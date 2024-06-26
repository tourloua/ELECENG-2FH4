clc;
k=8;
y_max=0.002;
y_min=-0.002;
steps=10000;
dy=((y_max-y_min)/steps);
H_total=[0 0 0];
for (i=0:steps)
    H_total(2)=H_total(2)-((k*dy)/(2*pi*sqrt(0.003^2+y_min^2)))*(0.003/sqrt(0.003^2+y_min^2));
    H_total(3)=H_total(3)-(((dy*k)/(2*pi*sqrt((0.003^2+(y_min)^2)))*((y_min)/sqrt(0.003^2+y_min^2))));
    y_min=y_min+dy;
end
