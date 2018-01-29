function [xsol, ysol] = taylor(x,y,dy,xstop,h)
    
    if size(y,1) > 1
        y = y';
    end
    
    xsol = zeros(2,1);
    ysol = zeros(2,length(y));
    xsol(1,1) = x;
    ysol(1,:) = y;
    k = 1;
    
    while x < xstop
        h = min(h,(xstop-x));
        d = feval(dy,x,y);
        hh = 1;
        for j = 1:4                     % For nth order solution do j = 1:n and define derivate dy and y upto nth derivative
           hh = hh*h/j;
           y = y + d(j,:)*hh;
        end
        
        x = x+h;
        k = k+1;
        xsol(k,1) = x;
        ysol(k,:) = y;
    end
    
end

%{ 
x       => Initial point
y       => Initial value in row vector
dy      => Derivatives of y till the order Taylor series is being considered
xtop    => Finial value at which solution is required
h       => Spacing used
%}