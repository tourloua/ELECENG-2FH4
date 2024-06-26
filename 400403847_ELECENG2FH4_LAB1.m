clc; %clear the command line
clear; %remove all previous variables
O=[0 0 0];%the origin
R1=[1 2 3];
R2=[3 2 1];
R1VEC=R1-O;
R2VEC=R2-O;
R1_DOT_R2=dot(R1VEC,R2VEC);%DOT PRODUCT OF R1VEC AND R2VEC
R2_DOT_R2=dot(R2VEC,R2VEC);
PROJ_R1_R2=((R1_DOT_R2/R2_DOT_R2)*R2VEC);%PROJECTION OF R1 ONTO R2
R1_MAG=norm(R1VEC);%MAGNITUDE OF R1
R2_MAG=norm(R2VEC);%MAGNITUDE OF R2
COS_theta=R1_DOT_R2/(R1_MAG*R2_MAG);
THETA=acos(COS_theta);
R1_DOT_R2,PROJ_R1_R2,THETA
