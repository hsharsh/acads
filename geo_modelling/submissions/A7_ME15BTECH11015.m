clc
clear
close all

u = 0:0.1:1;
v = 0:0.1:1;

x = size(length(u),length(v));
y = size(length(u),length(v));
z = size(length(u),length(v));

r = 20;

for i = 1:length(u)
    for j = 1:length(v)
        x(i,j) = r * sin(2*pi*u(i)) * cos(2*pi*v(j));
        y(i,j) = r * sin(2*pi*u(i)) * sin(2*pi*v(j));
        z(i,j) = r * cos(2*pi*u(i));        
    end
end

file = fopen('sphere.stl','w');

fprintf(file,'solid Sphere\n\n');
for i = 1:length(u)-1
    for j = 1:length(v)-1
        p1 = [x(i,j) y(i,j) z(i,j)];
        p2 = [x(i+1,j) y(i+1,j) z(i+1,j)];
        p3 = [x(i+1,j+1) y(i+1,j+1) z(i+1,j+1)];
        n = cross((p2-p1),(p3-p1));
        fprintf(file,'facet normal %f %f %f\n',n(1),n(2),n(3));
        fprintf(file,'\touter loop\n');
        fprintf(file,'\t\tvertex %f %f %f\n',p1(1),p1(2),p1(3));
        fprintf(file,'\t\tvertex %f %f %f\n',p2(1),p2(2),p2(3));
        fprintf(file,'\t\tvertex %f %f %f\n',p3(1),p3(2),p3(3));
        fprintf(file,'\tendloop\n');
        fprintf(file,'endfacet\n\n');

        p1 = [x(i,j+1) y(i,j+1) z(i,j+1)];
        p2 = [x(i+1,j+1) y(i+1,j+1) z(i+1,j+1)];
        p3 = [x(i+1,j) y(i+1,j) z(i+1,j)];        
        n = cross(p2-p1,p3-p1);
        fprintf(file,'facet normal %f %f %f\n',n(1),n(2),n(3));
        fprintf(file,'\touter loop\n');
        fprintf(file,'\t\tvertex %f %f %f\n',p1(1),p1(2),p1(3));
        fprintf(file,'\t\tvertex %f %f %f\n',p2(1),p2(2),p2(3));
        fprintf(file,'\t\tvertex %f %f %f\n',p3(1),p3(2),p3(3));
        fprintf(file,'\tendloop\n');
        fprintf(file,'endfacet\n\n');
    end
end

fprintf(file,'endsolid Sphere\n');
fclose(file);
