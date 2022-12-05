function Fv = M_system(~,x,A)
%   M_system describes the mutualistic dynamic
%   Fv = M_system(t,x,A)
%---Parameters for mutualistic¡ª¡ª dynamics-----------
s=1; a=1; gama=1; d=0.2;
[AZ,AF] = translate(A);

% AZ = A;
% AZ = full(AZ);
%---Parameters for mutualistic dynamics-----------
[m,n]=size(AZ);
%---Parameters for mutualistic dynamics-----------
Fv = -d*x-s*x.^2; 
% the interaction term
for i= 1:m
    L=find(AZ(:,i));
    M=find(AF(:,i));
    Fv(i) =Fv(i)+(gama*AZ(L,i)'*x(i)*x(L))/(a+AZ(L,i)'*x(L)+AF(M,i)'*x(M))...
                -(gama*AF(M,i)'*x(i)*x(M))/(a+AZ(L,i)'*x(L)+AF(M,i)'*x(M));
end
