
for number = 6 : 10
m = 10;
A = ones(m,m);

n = length(A);
 
ds = []; 
dx = []; %我加的
plnn = [];%p与x的关系

[i,j,s] = find(A);

steps = 1;
 while (steps <= length(s))   %次数还得改
    for sjbianliang = 1 : length(s)
        if A(i(sjbianliang),j(sjbianliang)) == 1 && unifrnd(0,1) < 0.1
           A(i(sjbianliang),j(sjbianliang)) = -1;
           [ds,dx,plnn]= iteration_real_M(steps,A,ds,dx,plnn);
           steps = steps + 1; 
       end
    end
end

 %保存此次结果 
filename   =  strcat('change',num2str(number),'.mat');
save(filename, 'dx','ds','plnn')
end