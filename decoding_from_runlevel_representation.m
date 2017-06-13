function output_vector = decoding_from_runlevel_representation (runlevel_representation,blocksize)
step = 0; temp_output_vector = [];
[m,n] = size(runlevel_representation);
for i = 1 : m
    for j = 1 : n
        if (j == 1 & runlevel_representation(i,1) ~= 0)
            for k = 1 : runlevel_representation(i,1)
                step = step + 1;
                temp_output_vector(1,step) = 0;
            end
        elseif (j == 2)
            step = step + 1;
            temp_output_vector(1, step) = runlevel_representation(i,2);     
        end
    end    
end
if (step ~= blocksize*blocksize)
        temp_output_vector(1 , blocksize*blocksize) = 0;
end
output_vector = temp_output_vector;

        
