clc
clear
close all

z = im2double(rgb2gray(imread('Input.jpg')));

x = zeros(size(z));
y = zeros(size(z));

m = max(max(z));
l = 3;
h = 8;


for i = 1:size(x,1)
    for j = 1:size(y,2)
        x(i,j) = i;
        y(i,j) = j;
        z(i,j) = l+ ((z(i,j)*1.0)/m)*(h-l);
    end
end

surf(x,y,z)
axis equal
file = fopen('lithophane.stl','w');

fprintf(file,'solid Sphere\n\n');
for i = 1:length(x)-1
    for j = 1:length(y)-1
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
        
        p1 = [x(i,j) y(i,j) z(i,j)];
        p2 = [x(i,j+1) y(i,j+1) z(i,j+1)];
        p3 = [x(i+1,j+1) y(i+1,j+1) z(i+1,j+1)];
                
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