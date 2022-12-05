function [dxend,ds,dx,plnn]= iteration_real_M(steps,A,ds,dx,plnn,dxend,gama,d)

%%---计算 P -----------
[AZ,AF] = translate(A);
sumlink = sum(AZ)+sum(AF);
sumcompete = sum(AF);
for stepsplnn = 1 : length(sumcompete)
    p(stepsplnn) = sumcompete(stepsplnn) / sumlink(stepsplnn);
end
% p1 = p;
% plnn(1,steps) = sum(p)/length(p);

% p(find(p>0)) = plnn(1,steps);
% plnn(1,steps) = sum(p)/length(p);

plnn1(1,steps) = sumlink*p'/sum(sumlink);
p(find(p>0)) = plnn1(1,steps);
plnn(1,steps) = sumlink*p'/sum(sumlink);

n = length(A); % number of nodes in the network
% A = A';
%---Parameters for iteration_synthetic_R-----------
t0 = 0; % the start time 
tf = 1000; % the end time 
x_low = 0.1;
x_high = 1;

%---Parameters for iteration_synthetic_R-----------

%% calculate the low state
x0 = ones(n,1)*x_low;  % Initial conditions
options = [];
[t,x] = ode45(@M_system,[t0,tf],x0,options,A,gama,d,plnn(1,steps)); 
xl_ss = x(end,:);
xl_ss = xl_ss'; 
%FL=x';

%% calculate the high state
x0 = ones(n,1)*x_high;  % Initial conditions
options = [];
[t,x] = ode45(@M_system,[t0,tf],x0,options,A,gama,d,plnn(1,steps)); 
xh_ss = x(end,:);xh_ss = xh_ss'; 
% FH=x';
%% calculate the results

%%---计算 β 及 xeff -----------
%---确保正矩阵--------------------------------------------------------
[i,j,s] = find(A);
for steps1 = 1:length(i)
    if s(steps1) < 0
        A(i(steps1),j(steps1)) = -1*A(i(steps1),j(steps1));
    end
end
ds(1,steps) = mean(sum(A));
% ds(1,steps) = dss;
dx(1,steps) = mean(xl_ss);
dx(2,steps) = mean(xh_ss);      
% dx(1,steps) = dxl;
% dx(2,steps) = dxh; 
s=2;
dxend(1,steps) = s*dx(1,steps)/(gama-d);
dxend(2,steps) = s*dx(2,steps)/(gama-d);


% filename   =  strcat('weight',num2str(steps),'_change','.mat');
% save(filename, 'dx','ds','plnn')
