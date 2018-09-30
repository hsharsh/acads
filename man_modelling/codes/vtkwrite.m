function vtkwrite(filename,varname,variable)
    fid = fopen(['./data/',filename],'w'); 
    fprintf(fid, '# vtk DataFile Version 3.0\n');
    fprintf(fid, 'VTK - Matlab export\n');
    fprintf(fid, 'ASCII\n');
    precision = 8;

    [nx, ny, nz] = size(variable);


    fprintf(fid, 'DATASET STRUCTURED_POINTS\n');
    fprintf(fid, 'DIMENSIONS %d %d %d\n', nx, ny, nz);
    fprintf(fid, ['SPACING ', num2str(1), ' ', num2str(1), ' ', num2str(1), '\n']);
    fprintf(fid, ['ORIGIN ', num2str(0), ' ', num2str(0), ' ', num2str(0), '\n']); 
    fprintf(fid, 'POINT_DATA %d\n', nx*ny*nz);
    fprintf(fid, ['SCALARS ', varname, ' float 1\n']);
    fprintf(fid,'LOOKUP_TABLE default\n');
    fprintf(fid, ['%0.', num2str(precision), 'f '], variable(:)');

    fclose(fid);
end