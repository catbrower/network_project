
for number = 6 : 10
m = 10;
A = ones(m,m);

n = length(A);
 
ds = []; 
dx = []; %�Ҽӵ�
plnn = [];%p��x�Ĺ�ϵ

[i,j,s] = find(A);

steps = 1;
 while (steps <= length(s))   %�������ø�
    for sjbianliang = 1 : length(s)
        if A(i(sjbianliang),j(sjbianliang)) == 1 && unifrnd(0,1) < 0.1
           A(i(sjbianliang),j(sjbianliang)) = -1;
           [ds,dx,plnn]= iteration_real_M(steps,A,ds,dx,plnn);
           steps = steps + 1; 
       end
    end
end

 %����˴ν�� 
filename   =  strcat('change',num2str(number),'.mat');
save(filename, 'dx','ds','plnn')
end