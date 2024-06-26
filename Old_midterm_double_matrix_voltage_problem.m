clc;
clear;
shift=11;
A=zeros(121,121);
B=zeros(121,1);
equation_counter=1;
for i=1:11
    for j=1:11
        if (i==1)
            A(equation_counter,equation_counter)=1;
            B(equation_counter)=0;
        elseif(i==11)
            A(equation_counter,equation_counter)=1;
            B(equation_counter)=0;
        elseif(j==1||j==11)
            A(equation_counter,equation_counter)=1;
            B(equation_counter)=0;
        elseif(i>2&&i<8&&j>2&&j<8)
            A(equation_counter,equation_counter)=1;
            B(equation_counter)=10;
        else
            A(equation_counter,equation_counter)=-4;
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
V_Square=reshape(V, 11, 11);%convert values into a rectangular matrix
surf(V_Square); %obtain the surface figure
xlabel("x(increments of 0.3mm)");
ylabel('y(increments of 0.3mm)');
zlabel("Voltage(V)");
title("Surface Plot of Voltage");

