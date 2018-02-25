function [xsol,ysol] = rk4(x,y,f,xstop,h)
    if size(y,1) > 1
        y = y';
    end
    xsol = zeros(2,1);
    ysol = zeros(2,length(y));
    k = 1;
    xsol(1,1) = x;
    ysol(1,:) = y;
    
    while(x<xstop)
        h = min(xstop-x,h);
        k1 = feval(f,x,y);
        k2 = feval(f,x+h/2,y+(h/2)*k1);
        k3 = feval(f,x+h/2,y+(h/2)*k2);
        k4 = feval(f,x+h,y+h*k3);
        
        x = x+h;
        y = y + (h/6)*(k1+2*k2+2*k3+k4);
        k = k+1;
        xsol(k,1) = x;
        ysol(k,:) = y;
    end
end