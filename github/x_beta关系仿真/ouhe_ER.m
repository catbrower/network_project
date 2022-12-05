function A = ouhe_ER(meank,n,aij)
%   随机生成带-1的耦合矩阵


link = fix(meank*n/2);
A = zeros(n);
A = sparse(A);
while 1
    i = fix(rand*n)+1;
    j = fix(rand*n)+1;
    if (A(i,j)==0 && i~=j)
       if rand < 0.0
        A(i,j) = -1*aij;
        A(j,i) = -1*aij;
        link=link-1;
       else
          A(i,j) = aij;
        A(j,i) = aij;
        link=link-1;
       end
    end
    if link==0
        break;
    end
    
end
%A = generate_ER(8,100,1);％％这个是生成ＥＲ网络