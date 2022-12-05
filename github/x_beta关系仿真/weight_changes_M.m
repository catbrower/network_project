for num = 31 : 40

%   Inputs:
%       A : Adjacency matrix of the network

% load PLANT_POLLINATOR_BEES_WASPS_Elberling_1999
 A = ouhe_ER(8,50,1);
% [A,D]=BA(100,5,80);    100第一次做
%load D100
n = length(A);
steps = 0;

ds = []; 
dx = []; %我加的
plnn = [];%p与x的关系
%---Random initial perturbation to the network-----------------------

A0 = A;

%---Random initial perturbation to the network-----------------------

%--- every step we reduce 2% of weights----can be changed------------
for i = 0:0.04:2.4
%--- every step we reduce 2% of weights----can be changed------------

    A = i*A0;
    steps = steps+1;
    [ds,dx,plnn]= iteration_real_M(steps,A,ds,dx,plnn); 

end
    filename   =  strcat('weight',num2str(num), '.mat');
    save(filename,  'ds', 'dx', 'plnn');  
end

