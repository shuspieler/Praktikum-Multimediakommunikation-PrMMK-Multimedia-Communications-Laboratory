function output_image = blockbased_motion_compensation(input_image,blocksize,searchrange,motion_vectors)
padded_input_image = padarray(input_image, [searchrange, searchrange], 'replicate','both');
[n,m] = size (input_image);
p=1;
for j = 1:blocksize : (n)  %rows
    for i = 1:blocksize: (m)  %columms
        Temp (j : j+blocksize-1 , i : i+blocksize-1) = padded_input_image( j + motion_vectors(p,1) + searchrange : j+ motion_vectors(p,1) + searchrange+blocksize-1 , i + motion_vectors(p,2) + searchrange : i+ motion_vectors(p,2) + searchrange+blocksize-1 );
        p =p+1;
    end
end
output_image = Temp;

        
