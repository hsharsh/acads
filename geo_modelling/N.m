function Nik = N(i,k,t,u)    
    Nik = 0;
    if k == 1
        Nik = N1(i,u,t);
    else
        if t(i+k)-t(i+1) ~= 0
            Nik = Nik + ((u-t(i+1))*N(i,k-1,t,u))/(t(i+k)-t(i+1));
        end
        
        if t(i+k+1)-t(i+2) ~= 0
            Nik = Nik + ((t(i+k+1)-u)*N(i+1,k-1,t,u))/(t(i+k+1)-t(i+2));
        end
    end
    disp([num2str(i),',',num2str(k),': ',num2str(Nik)]);
end
