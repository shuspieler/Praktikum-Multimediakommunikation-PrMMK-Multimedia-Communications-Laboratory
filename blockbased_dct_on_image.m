function output_image=blockbased_dct_on_image(input_image,blocksize)
[m,n] = size(input_image);
a = rem (m, blocksize);
b = rem (n, blocksize);
A = (m+blocksize-a)/blocksize;
B = (n+blocksize-b)/blocksize;
Temp_image = input_image;


if(a ~= 0)
    for i = m+1 : m+blocksize-a
        for j = 1 : n
            Temp_image(i,j) = 0;
        end
    end
end
[p,q] = size (Temp_image);
if (b ~= 0)
    for i = n+1 : n+blocksize -b
        for j = 1: p
            Temp_image(j,i)=0;
        end
    end
end
[x,y] = size (Temp_image);
for i=1:blocksize:x
   for j=1:blocksize:y
      block_Temp_image=Temp_image(i:i+blocksize-1,j:j+blocksize-1); 
      Temp_output_image(i:i+blocksize-1,j:j+blocksize-1) = dct2(block_Temp_image);
   end
end
output_image=Temp_output_image;
