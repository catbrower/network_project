for num = 21 : 30

%   Inputs:
%       A : Adjacency matrix of the network

% load PLANT_POLLINATOR_BEES_WASPS_Elberling_1999
A = ouhe_ER(8,100,1);
% [A,D]=BA(100,5,80);    100第一次做
%load D100
n = length(A);
steps = 0;

ds = []; 
dx = []; %我加的
plnn = [];%p与x的关系
gama = [];
%---Random initial perturbation to the network-----------------------

A0 = A;
gama0=0.3:0.01:5;%改变权重的范围
%---Random initial perturbation to the network-----------------------

%--- every step we reduce 2% of weights----can be changed------------
for i = 1:length(gama0)
%--- every step we reduce 2% of weights----can be changed------------

    A = A0;
    steps = steps+1;
    [ds,dx,plnn]= iteration_real_M(steps,A,ds,dx,plnn,gama0(steps)); 
    gama(steps) = (1-plnn(steps))*gama0(steps)-plnn(steps)*gama0(steps);
end
    filename   =  strcat('gama',num2str(num), '.mat');
    save(filename,  'ds', 'dx', 'plnn', 'gama');  
end

