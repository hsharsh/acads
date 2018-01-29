function [x,nIter] = newton(f,xo,J)
    epsilon = 1e-10;
    N = 100;
    maxval = 1e10;
    x = xo;
    while N > 0
       JJ = feval(J,x);                                   % feval(J,x) for 'Jac' and feval(J,f,x) for 'Jdiff'
       if abs(det(JJ)) < epsilon
           error('Newton Rhapson Jacobian is singular.');
           abort;
       end
       xn = x - JJ \ feval(f,x);
       
       if abs(feval(f,xn)) < epsilon
           nIter = 99-N;
           disp(['Iteration: ', num2str(nIter)]);
           return;
       end
       
       if abs(feval(f,xn)) > maxval
           nIter = 99-N;
           disp(['Iteration: ', num2str(nIter)]);
           error('Diverging solution.');
           abort;
       end
       N = N-1;
       x = xn;
    end
    x = NaN; nIter = NaN;
end