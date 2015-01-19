% Based on Bortfeld 1997: An analytical approximation of the Bragg curve
% for therapeutic proton beams
% Last edited: 19th Jan
% Command line file to adjust parameters, plot graphs from functions

close all; clear all; clc; clear mem;

% declaring constants/parameters
E0=150; %E0 in units of MeV
alpha=2.2e-3;
p=1.77;
rho=1;
R0=range(alpha,E0,p); %R in units of cm
beta=0.012;
sigma=0.012*(R0^0.935);
gamma=0.6;
phi0=1000;
epsilon=0.2;

% testing functions
R=0:0.1:R0*1.1;
d=0:0.1:R0*1.1;
% R=0:0.1:R0;
% d=0:0.1:R0;
z=zetafunc(R0,d,sigma);

% % testing parabolic cyl function
% [testmz,terms]=parafunc(-1/p,-z);
% figure(2);
% plot(d,testmz);
 
D_zapprox=dose(phi0,sigma,beta,alpha,gamma,E0,p,d,rho,1);
D_z=dose(phi0,sigma,beta,alpha,gamma,E0,p,d,rho,0);
Dhat_z=dosehat(phi0,beta,alpha,gamma,E0,p,d,rho);
% D_h20=doseh20(phi0,sigma,alpha,epsilon,E0,p,d);
% 
figure(3);
plot(d,D_z./fluence(phi0,beta,R0,d)); hold on;
ylabel('Dose per fluence');
plot(d,Dhat_z./fluence(phi0,beta,R0,d));
figleg=legend('D(z)','$\hat{D}$(z)'); set(figleg,'Interpreter','Latex');
% 
% 
% figure(2);
% plot(d,D_h20);