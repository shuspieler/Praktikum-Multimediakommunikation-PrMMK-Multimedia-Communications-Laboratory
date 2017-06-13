function decoder_basic_intra(coded_file,decoded_yuv_file)
load(coded_file);
[bitstream signal] = decode_signal_from_huffman_bitstream(bitstream, huffman_table);
quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
signal_Temp=signal(:,1);
EOB=find(signal_Temp == -1);
[m n]=size(EOB); 
blocknumber=(width * height)/(transform_blocksize*transform_blocksize);
for p=blocknumber:blocknumber:m  
    if (p == blocknumber)
        Temp_frame = signal(1:EOB(p),:);
    else
        Temp_frame = signal(EOB(p-blocknumber)+1:EOB(p),:);
    end
    tamp_reversed_zigzag_scanned = blockbased_decoding_from_runlevel_representation(Temp_frame, transform_blocksize);
    temp_decoded_from_zigzag_out_image = blockbased_decoding_from_zigzag_scanned(tamp_reversed_zigzag_scanned, transform_blocksize, width, height);
    temp_dequantized_output_image = blockbased_dequantizer_from_levels(temp_decoded_from_zigzag_out_image , quantisation_matrix);
    output_image = blockbased_idct_on_image (temp_dequantized_output_image , transform_blocksize);
    [m,n] = size(output_image);
for i = 1 : m
    for j = 1 : n
        if (output_image(i,j) > 1 )
            output_image(i,j) = 1;
        elseif(output_image(i,j)< 0 )
            output_image(i,j) = 0;
        end
    end
end
    retval = yuv_write_one_frame(decoded_yuv_file,p/blocknumber,output_image);
end