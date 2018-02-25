function [Q,R] = gram_schmidt(A)
    Q = zeros(size(A));
    R = zeros(size(A));
    for i = 1:size(A,2)
        u = A(:,i)/norm(A(:,i));
        w = u;
        for j = 1:i-1
            w = w - Q(:,j)*(dot(u,Q(:,j)));
        end
        Q(:,i) = w/norm(w);
        for j = 1:i
            R(j,i) = dot(A(:,i),Q(:,j));
        end
        
    end
end