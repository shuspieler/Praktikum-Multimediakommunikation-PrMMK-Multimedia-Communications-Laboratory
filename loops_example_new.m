% Example for a double for-loop

% Comment after an empty line
% is not shown by the help function!

n=4;
for i=1:n-1
  for j=1:n-1
    rows	= (1:288/n) + i*288/n;
    cols	= (1:352/n) + j*352/n;
imshow(fg(rows,cols))
disp('weiter mit beliebieger Taste'), 
end
end
