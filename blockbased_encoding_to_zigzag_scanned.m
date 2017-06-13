function zigzag_scanned = blockbased_encoding_to_zigzag_scanned(input_image,blocksize)
[m n]=size(input_image);
k=1;
for  i = 1:blocksize:m
 for    j = 1:blocksize:n
    block_matrix = input_image(i:i+blocksize-1 , j:j+blocksize-1);
    temp_matrix=encoding_to_zigzag_scanned(block_matrix);
    temp_zigzag_matrix(k,:)=temp_matrix;
    k=k+1;
 end
end
zigzag_scanned= temp_zigzag_matrix;