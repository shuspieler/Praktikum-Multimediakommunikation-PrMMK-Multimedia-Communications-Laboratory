function output_image=blockbased_idct_on_image(input_image,blocksize)
[x,y] = size (input_image);
for i=1:blocksize:x
   for j=1:blocksize:y
      block_Temp_image=input_image(i:i+blocksize-1,j:j+blocksize-1); 
      Temp_output_image(i:i+blocksize-1,j:j+blocksize-1) = idct2(block_Temp_image);
   end
end
output_image=Temp_output_image;