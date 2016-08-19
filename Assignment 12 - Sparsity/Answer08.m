clear;

% Making inputs
b = [-2, -6, -9, 1, 8, 10, 1, -9, -4, -3]';
S = 3;
% % Making matrix A
A = zeros(10, 10);
for i = 1:10
    for j = 1:10
        A(i, j) = sin(i+j);
    end
end

A = A + eye(10);
A = normc(A);
%{
display(A);
%}

%% Orthogonal Matching Pursuit (OMP)
r = b;
Omega = [];

projections = zeros(size(A, 2), 1);

A_Omega = zeros(size(A));

display(sum((r.^2)));
while length(Omega) < S
    for i = 1:size(A, 1)
        if ~ismember(i, Omega)
            projections(i) = abs(A(:, i)' * r);
        else
            projections(i) = 0;
        end
    end
    [m, i] = max(projections);
    Omega = [Omega i];
    for j = 1:size(A, 2)
        A_Omega(j, i) = A(j, i);
    end
    x_star = A_Omega' * pinv(A_Omega * A_Omega') * b;
    r = b - A_Omega * x_star;
    display(sum(r.^2));
end



