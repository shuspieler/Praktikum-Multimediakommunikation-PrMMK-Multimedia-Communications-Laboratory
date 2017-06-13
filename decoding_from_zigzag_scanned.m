function output_image=decoding_from_zigzag_scanned(zigzag_scanned,width,height)
permutation_matrix = generate_zigzag_permutation_matrix(width,height);
for i=1:width*height
    [m n]=find(permutation_matrix==i);
    Temp_matrix(m,n)=zigzag_scanned(i);
end
output_image=Temp_matrix;