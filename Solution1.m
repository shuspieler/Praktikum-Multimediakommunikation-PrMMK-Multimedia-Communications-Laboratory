
%%
%E-20-22
imshow(fg*0.5)
imshow(fg.^0.5)
%%
%E-27
imshow(blkproc(fg,[50 100],'diag_mask'))
%%
%E-28
for i=1:5
frame=yuv_read_one_frame('flowergarden_short_cif.yuv',i,352,288)
imshow(frame)
pause(0.5)
end

%%
%E-29
D = cell (5,2)
D{1,1} = 'point'
D{2,1} = 'line'
D{3,1} = 'triangle'
D{4,1} = 'rectangle'
D{5,1} = 'cuboid'
D{1,2} = [0 0]
D{2,2} = [0 0; 0 1]
D{3,2} = [0 0; 0 1; 1 0.5]
D{4,2} = [0 0; 0 1; 1 1; 1 0]
D{5,2} = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1]

celldisp(D)
cellplot(D)

%%
%E-30
plot_geomeries(D)
%E-31

