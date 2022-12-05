function [AZ,AF] = translate(A)

[i,j,s] = find(A);

AZ = A;
AF = A;
for steps = 1:length(i)
    if s(steps) > 0
        AF(i(steps),j(steps)) = 0;
    end
    if s(steps) < 0
        AF(i(steps),j(steps)) = -1*AF(i(steps),j(steps));
    end
end

for steps = 1:length(i)
    if s(steps) < 0
        AZ(i(steps),j(steps)) = 0;
    end
end

end