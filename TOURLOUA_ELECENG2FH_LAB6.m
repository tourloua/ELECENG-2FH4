clc;
clear;
%x axis is from top left to top right corner
%y axis is from top left to bottom left corner
equation_counter=1;
A=zeros(2601,2601); %dimensions of our matrix. We will have 51 equations
B=zeros(2601,1); %right side
shift=51;
for i=1:51
    for j=1:51
        if (i==1)
            if (j~=26)%sets the entire top row of points to 50 V except for the 
                % point in the middle...
                A(equation_counter,equation_counter)=1;
                B(equation_counter)=50;
            else
                A(equation_counter,equation_counter)=-4;%...which is the 0V gap
                A(equation_counter,equation_counter-1)=1;
                A(equation_counter,equation_counter+1)=1;
                A(equation_counter,equation_counter+51)=1;%point in row below
                B(equation_counter)=0;
            end
       elseif ((j==1)||(j==51))%sets the left and right walls to 0V
           if (i~=2)
                    A(equation_counter,equation_counter)=1;
                    B(equation_counter)=0;
                else
                    A(equation_counter,equation_counter)=-4;
                    A(equation_counter,equation_counter+1)=1;%right
                    A(equation_counter,equation_counter-1)=1;%left
                    A(equation_counter,equation_counter+51)=1;%above
                    A(equation_counter,equation_counter-51)=1;%below
                    B(equation_counter)=0;
           end
      elseif ((i>1)&&(i<27)&&(j==26))%100V vertical charge
                A(equation_counter,equation_counter)=1;
                B(equation_counter)=100;
      elseif (i==51)%sets lowest row to 0V
                A(equation_counter,equation_counter)=1;
                B(equation_counter)=0;
    else
        A(equation_counter,equation_counter)=-4;%all other points
        A(equation_counter,equation_counter+1)=1;
        A(equation_counter,equation_counter-1)=1;
        A(equation_counter,equation_counter+shift)=1;
        A(equation_counter,equation_counter-shift)=1;
        B(equation_counter)=0;
        end
    equation_counter=equation_counter+1;
    end
    
end
V=A\B;
 %obtain the vector of voltages 
V_Square=reshape(V, 51, 51);%convert values into a rectangular matrix
surf(V_Square); %obtain the surface figure
xlabel("x(increments of 0.8mm)");
ylabel('y(increments of 0.8mm)');
zlabel("Voltage(V)");
title("Surface Plot of Voltage");
figure;
[C,h] = contour(V_Square);% obtain the contour figure
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap cool;
title("Contour of Voltages");
xlim([1 51]);
ylim([1 51]);
xticks([1 11 21 31 41 51]);
xticklabels({'0', '10', '20', '30', '40','50'});
yticks([1 11 21 31 41 51]);
yticklabels({'0', '10', '20', '30', '40', '50'});
xlabel("x(increments of 0.8mm)");
ylabel('y(increments of 0.8mm)');
figure;
contour(V_Square);
[px,py] = gradient(V_Square);
hold on, quiver(-px,-py), hold off
xlim([1 51]);
ylim([1 51]);
xticks([1 11 21 31 41 51]);
xticklabels({'0', '10', '20', '30', '40','50'});
yticks([1 11 21 31 41 51]);
yticklabels({'0', '10', '20', '30', '40', '50'});
title("Electric Field Lines");
xlabel("x(increments of 0.8mm)");
ylabel('y(increments of 0.8mm)');