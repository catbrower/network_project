clc
clear
% figure1 = figure('color',[1 1 1]);
% axes1 = axes('Parent',figure1,'XScale','log');%
% box(axes1,'on');
% hold(axes1,'on');
%% Initial parameters
d=0.2; s=1;a=1;  
betas1=8;
% x=0:0.002:1;
gama=d+0.1:0.002:5;

for steps = 1 : length(gama)

aa = betas1*s;
bb = d*betas1-gama(steps)*betas1+s*a;
cc = d*a;

xxx1(steps) = (-bb + sqrt(bb.*bb - 4.*aa.*cc) )./(2.*aa);
xxx2(steps) = (-bb - sqrt(bb.*bb - 4.*aa.*cc) )./(2.*aa);
end
plot(gama,xxx1,'-k','LineWidth',1); hold on
plot(gama,xxx2,'--k','LineWidth',1); hold on

%%
for num = 1 : 10  
filename1 = strcat('gama',num2str(num), '.mat');
load (filename1);

plot(gama,dx(1,:),'.g');
hold on
end

for num = 11 : 20  
filename1 = strcat('gama',num2str(num), '.mat');
load (filename1);

plot(gama,dx(1,:),'.b');
hold on
end

for num = 21 : 22  
filename1 = strcat('gama',num2str(num), '.mat');
load (filename1);

plot(gama,dx(1,:),'.r');
hold on
end

%% 
axis([0.2 2.2 0 0.84]);
ylabel('<x>'),
xlabel('gama');

set(gca,'FontSize',16) 
delete(get(gca,'title'))