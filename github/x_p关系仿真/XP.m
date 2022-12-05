clc
clear
% figure1 = figure('color',[1 1 1]);
% axes1 = axes('Parent',figure1,'YScale','log');%
% box(axes1,'on');
% hold(axes1,'on');
%% Initial parameters
d=0.2; s=1;a=1; gama1=1; gama2=1; ds = 10;
r1=gama1;
r2=gama2;
% x=0:0.002:1;
p=0:0.001:1;

for steps = 1 : length(p)
betas1=ds;
gama = (1-p(steps))*r1-p(steps)*r2;

aa = betas1*s;
bb = d*betas1-gama*betas1+s*a;
cc = d*a;

xxx1(steps) = (-bb + sqrt(bb.*bb - 4.*aa.*cc) )./(2.*aa);
xxx2(steps) = (-bb - sqrt(bb.*bb - 4.*aa.*cc) )./(2.*aa);
end
plot(p,xxx1,'-k','LineWidth',1); hold on
plot(p,xxx2,'--k','LineWidth',1); hold on
%% simulate
for num = 1 : 10  
filename1 = strcat('change',num2str(num), '.mat');
load (filename1);

plot(plnn,dx(1,:),'.r');
hold on
end
for num = 11 : 20  
filename1 = strcat('change',num2str(num), '.mat');
load (filename1);

plot(plnn,dx(1,:),'.b');
hold on
end
for num = 21 : 30  
filename1 = strcat('change',num2str(num), '.mat');
load (filename1);

plot(plnn,dx(1,:),'.g');
hold on
end

%% 
axis([0 0.5 0 0.84]);
ylabel('<x>'),
xlabel('p');

set(gca,'FontSize',16) 
delete(get(gca,'title'))