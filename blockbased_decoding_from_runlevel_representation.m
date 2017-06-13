function zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation,blocksize)
runlevel_representation_new=runlevel_representation(:,1);
eob_collumn = find (runlevel_representation_new==-1);
[m n] = size(eob_collumn);
for i=1:m
    if (i == 1)
        block_runlevel_representation=runlevel_representation(1:(eob_collumn(i)-1),:);
        temp_output_vector(i,:) = decoding_from_runlevel_representation (block_runlevel_representation,blocksize);
    else
        block_runlevel_representation=runlevel_representation(eob_collumn(i-1)+1:(eob_collumn(i)-1),:);
        temp_output_vector(i,:) = decoding_from_runlevel_representation (block_runlevel_representation,blocksize);
    end
end
zigzag_scanned = temp_output_vector