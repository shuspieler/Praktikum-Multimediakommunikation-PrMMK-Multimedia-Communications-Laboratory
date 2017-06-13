function motion_vector =get_motion_vector_for_block(padded_input_image,padded_previous_image,blockstart_x,blockstart_y,blocksize,searchrange)
[m,n] = size (padded_input_image);
%padded_previous_image_block = padded_previous_image(blockstart_x:blockstart_x+blocksize-1,blockstart_y:blockstart_y+blocksize-1);
padded_input_image_block = padded_input_image(blockstart_y:blockstart_y+blocksize-1,blockstart_x:blockstart_x+blocksize-1);
Sad = Inf;
for i = -searchrange:searchrange                        
    for j =-searchrange:searchrange                     
        padded_previous_image_block = padded_previous_image(blockstart_y+i : blockstart_y+i+blocksize-1 , blockstart_x+j: blockstart_x+j+blocksize-1);
        Temp = calculate_sad (padded_previous_image_block,padded_input_image_block);
        if (Temp < Sad)
            Sad = Temp;
            p = i;
            q = j;
        end
    end
end
motion_vector = [p,q];        