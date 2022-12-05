clc
clear
%% 参数
d=0.2; s=1;a=1; gama1=1; gama2=1; 
r1=gama1;
r2=gama2;
%% 函数

[p,sm ] = meshgrid(0 : 0.02 : 0.7, 1 : 0.1 : 15);

aa = sm.*s;
bb = d.*sm-((1-p)*r1-p*r2).*sm+s*a;
cc = d*a;

xxx1 = (-bb + sqrt(bb.*bb - 4.*aa.*cc) )./(2.*aa);
xxx2 = (-bb - sqrt(bb.*bb - 4.*aa.*cc) )./(2.*aa);

[ii,jj] = size(xxx1);
for iii = 1 : ii
    for jjj = 1 :jj
        xxx1(iii,jjj) = real(xxx1(iii,jjj));
    end
end

[ii,jj] = size(xxx2);
for iii = 1 : ii
    for jjj = 1 :jj
        xxx2(iii,jjj) = real(xxx2(iii,jjj));
    end
end

%% 输出结果
mesh(p,sm,xxx1);  
alpha(0.0001)
hold on
mesh(p,sm,xxx2);  
alpha(0.0001)

load outgoing8
scatter3(plnn,ds,dx(2,1),'pg') 
hold on

load outgoing11
scatter3(plnn,ds,dx(2,1),'db')
hold on

load outgoing40
scatter3(plnn,ds,dx(2,1),'or') 
hold on

load outgoing46
scatter3(plnn,ds,dx(2,1),'sm') 
hold on

load outgoing1
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing2
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing5
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing17
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing19
scatter3(plnn,ds,dx(2,1),'*r')  
hold on

load outgoing24
scatter3(plnn,ds,dx(2,1),'*r')  
hold on

load outgoing25
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing30
scatter3(plnn,ds,dx(2,1),'*r')  
hold on

load outgoing52
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing43
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing41
scatter3(plnn,ds,dx(2,1),'*r')  
hold on

load outgoing35
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing33
scatter3(plnn,ds,dx(2,1),'*r') 
hold on

load outgoing31
scatter3(plnn,ds,dx(2,1),'*r') 


axis([0 0.37 0.3 13.8 0 0.7])

set(gca,'FontSize',18) 