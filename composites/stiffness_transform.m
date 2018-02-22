function T = stiffness_transform(theta)
    T = [
        cos(theta)^2            sin(theta)^2            2*sin(theta)*cos(theta);
        sin(theta)^2            cos(theta)^2            -2*sin(theta)*cos(theta);
        -sin(theta)*cos(theta) sin(theta)*cos(theta)  cos(theta)^2-sin(theta)^2
        ];
    
end