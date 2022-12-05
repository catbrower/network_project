clc
clear
% figure1 = figure('color',[1 1 1]);
% axes1 = axes('Parent',figure1,'XScale','log');%
% box(axes1,'on');
% hold(axes1,'on');
%% Initial parameters
d=0.2; s=1;a=1; gama1=1; gama2=1; p = 0.00;
r1=gama1;
r2=gama2;
% x=0:0.002:1;
ds=1:0.002:100;

for steps = 1 : length(ds)
betas1=ds(steps);
gama = (1-p)*r1-p*r2;

aa = betas1*s;
bb = d*betas1-gama*betas1+s*a;
cc = d*a;

xxx1(steps) = (-bb + sqrt(bb.*bb - 4.*aa.*cc) )./(2.*aa);
xxx2(steps) = (-bb - sqrt(bb.*bb - 4.*aa.*cc) )./(2.*aa);
end
plot(ds,xxx1,'-k','LineWidth',1); hold on
plot(ds,xxx2,'--k','LineWidth',1); 

%%
for num = 1 : 15  
filename1 = strcat('weight',num2str(num), '.mat');
load (filename1);

plot(ds,dx(1,:),'.g');
hold on
end

for num = 15 : 30  
filename1 = strcat('weight',num2str(num), '.mat');
load (filename1);

plot(ds,dx(1,:),'.r');
hold on
end

for num = 31 : 40  
filename1 = strcat('weight',num2str(num), '.mat');
load (filename1);

plot(ds,dx(1,:),'.b');
hold on
end
%% 
axis([1 18 0 0.84]);
ylabel('<x>'),
xlabel('<s>');

set(gca,'FontSize',16) 
delete(get(gca,'title'))