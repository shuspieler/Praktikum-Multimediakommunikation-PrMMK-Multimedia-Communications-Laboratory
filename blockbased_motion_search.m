function motion_vectors=blockbased_motion_search(input_image,previous_image,blocksize,searchrange)
[m,n] = size (input_image);
p = 0;
padded_input_image = padarray(input_image, [searchrange, searchrange], 'replicate','both');
padded_previous_image = padarray(previous_image, [searchrange, searchrange], 'replicate','both');
for j =1: (m/blocksize)
    for i = 1: (n/blocksize)
        blockstart_x = (i-1) * blocksize +1 + searchrange;
        blockstart_y = (j-1) * blocksize +1 + searchrange;
        motion_vector =get_motion_vector_for_block(padded_input_image,padded_previous_image,blockstart_x,blockstart_y,blocksize,searchrange);
        motion_vectors(p+1,:) =motion_vector;
        [p,q] = size (motion_vectors); 
    end
end
