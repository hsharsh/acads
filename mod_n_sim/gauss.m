function [x,det] = gauss(A,b)
    if size(b,2) > 1
        b = b';
    end
    
    n = length(b);
    for k = 1:n-1
        for i = k+1:n
            l = A(i,k)/A(k,k);
            A(i,k:n) = A(i,k:n) - l*A(k,k:n);
            b(i) = b(i) - l*b(k);
        end
    end
    
    if nargout == 2
        det = prod(diag(A));
    end
    
    b(n) = b(n)/A(n,n);
    
    for k = n-1:-1:1
        b(k) = ((b(k) - A(k,k+1:n)*b(k+1:n))/A(k,k));
    end
    x = b;
end
