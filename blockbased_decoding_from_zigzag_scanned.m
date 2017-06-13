function output_image = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, blocksize, width, height)
[m n]=size(zigzag_scanned);
k=1
for  i = 1:blocksize:height
  for    j = 1:blocksize:width
    temp_matrix=  zigzag_scanned(k,:);
    block_matrix = decoding_from_zigzag_scanned(temp_matrix,blocksize,blocksize);  
    temp_zigzag_matrix(i:i+blocksize-1,j:j+blocksize-1)=block_matrix;
    k=k+1;
 end
end
output_image= temp_zigzag_matrix;