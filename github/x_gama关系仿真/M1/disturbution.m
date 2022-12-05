function A = disturbution(A,sigma)
% ±ê×¼²îsigma
% A = [0,1,1,1;
%     1,0,1,1;
%     1,1,0,1;
%     1,1,1,0;];
% sigma = 0.2;
A1 =A;
[i,j,s] = find(A1);
for steps = 1:length(i)
    if s(steps) ~= 0
        A1(i(steps),j(steps)) = 1;
    end
end

number_link = sum(A1');
[mm,nn] = size(A);

for ii = 1 : length(number_link)
    disturbute = normrnd(0,sigma,1,number_link(ii));
%     if min(disturbute) > -1 && max(disturbute) < 2
        steps = 1;
        for jj = 1 : nn
           if A(ii,jj) ~= 0
               A(ii,jj) = A(ii,jj) + disturbute(steps);
               steps = steps + 1;
           end
        end
%     else
%         disturbute = normrnd(0,sigma,1,number_link(ii));
%         ii = ii - 1;
%     end
end

end