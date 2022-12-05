clc
clear
    
% A = ouhe_ER(8,50,1);
load M1R07.mat
%---去除孤立节点------------------------------------------------------
cluster = find_gaint_component(A); 
A = A(cluster,cluster); 

d=0.05; s=2;a=1;
for steppp= 1 : 10

A1 = disturbution(A,0.0);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_da0',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end

for steppp= 1 : 10

A1 = disturbution(A,0.2);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_da2',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end

for steppp= 1 : 10

A1 = disturbution(A,0.8);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_da8',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end

d=0.2; s=2;a=1;
for steppp= 1 : 10

A1 = disturbution(A,0.0);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_db0',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end

for steppp= 1 : 10

A1 = disturbution(A,0.2);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_db2',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end

for steppp= 1 : 10

A1 = disturbution(A,0.8);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_db8',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end

d=0.5; s=2;a=1;
for steppp= 1 : 10

A1 = disturbution(A,0.0);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_dc0',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end

for steppp= 1 : 10

A1 = disturbution(A,0.2);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_dc2',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end

for steppp= 1 : 10

A1 = disturbution(A,0.8);%sigma标准差 0.2 0.5 0.8

%---初始化-----------------------------------------------------------
steps = 0;

ds = []; 
dx = []; %我加的
dxend = [];
plnn = [];%p与x的关系
kgama = [];
mykgama = [];
xxx = [];
xxxend = [];

%---other parameter--------------------------------------------------

%---Random initial perturbation to the network-----------------------
w=d+0.1:0.1:5;%改变权重的范围
% w=3;
for i=1:length(w)
    steps = steps+1;    
    G0=A1;
%     G0=G0*w(i);
    gama = w(i);
    
    [dxend,ds,dx,plnn]= iteration_real_M(steps,G0,ds,dx,plnn,dxend,gama,d); 
    
    betas1=ds(steps);
    gama = (1-plnn(steps))*w(i)-plnn(steps)*w(i);

    aa = betas1*s;
    bb = d*betas1-gama*betas1+s*a;
    cc = d*a;

    xxx(1,steps) = (-bb + sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    xxx(2,steps) = (-bb - sqrt(bb*bb - 4*aa*cc) )/(2*aa);
    
    
    kgama(steps) = a*s*(gama+d)/((gama-d)^2);
    mykgama(steps) = a*s/(sqrt(gama)-sqrt(d))^2;
    xxxend(1,steps) = s*xxx(1,steps)/(gama-d);
    xxxend(2,steps) = s*xxx(2,steps)/(gama-d);
end

filename   =  strcat('weight_dc8',num2str(steppp),'_change','.mat');
save(filename, 'dx','ds','plnn','kgama','xxx','xxxend','dxend','mykgama')
end


