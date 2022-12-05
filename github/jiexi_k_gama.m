clc
clear
% figure1 = figure('color',[1 1 1]);
% axes1 = axes('Parent',figure1,'YScale','log');%
% box(axes1,'on');
% hold(axes1,'on');
%% Initial parameters
% d=0.05; s=1;a=1; p = 0;
% gama = 0 : 0.01: 2;
% r1 = gama; r2 = gama;
% k_gama = a*s*((1-p).*r1-p.*r2+d)./((1-p).*r1-p.*r2-d).^2;
% 
% plot(gama,k_gama,'--g','LineWidth',1);  hold on

d=0.1; s=1;a=1; p = 0.0;
gama = 0 : 0.01: 2;
r1 = gama; r2 = gama;
k_gama = a*s*((1-p).*r1-p.*r2+d)./((1-p).*r1-p.*r2-d).^2;

plot(gama,k_gama,'-k','LineWidth',1);  hold on

% d=0.2; s=1;a=1; p = 0.1;
% gama = 0 : 0.01: 2;
% r1 = gama; r2 = gama;
% k_gama = a*s*((1-p).*r1-p.*r2+d)./((1-p).*r1-p.*r2-d).^2;
% 
% plot(gama,k_gama,'--r','LineWidth',1); 

%% 
axis([0.3 1.49 0 6.3]);
ylabel('k_\gamma'),
xlabel('\gamma');

set(gca,'FontSize',16) 
delete(get(gca,'title'))