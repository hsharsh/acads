function Ni1 = N1(i,u,t)
    Ni1 = 0;
    if u >= t(i+1) && u < t(i+2)
        Ni1 = 1;
    end
end