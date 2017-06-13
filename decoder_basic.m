function decoder_basic(coded_file,decoded_yuv_file)
load(coded_file); frame_buffer = [];
[bitstream_runlevel_difference_frame signal_runlevel] = decode_signal_from_huffman_bitstream(bitstream_runlevel_difference_frame, huffman_table_runlevel_difference_frame);
[bitstream_runlevel_difference_frame_U signal_runlevel_U] = decode_signal_from_huffman_bitstream(bitstream_runlevel_difference_frame_U, huffman_table_runlevel_difference_frame_U);
[bitstream_runlevel_difference_frame_V signal_runlevel_V] = decode_signal_from_huffman_bitstream(bitstream_runlevel_difference_frame_V, huffman_table_runlevel_difference_frame_V);
transform_blocksize_UV = transform_blocksize/2;  me_searchrange_UV = me_searchrange/2;

[bitstream_motion_vectors_all signal_motion] = decode_signal_from_huffman_bitstream(bitstream_motion_vectors_all, huffman_table_motion_vectors_all);
motion_vectors_all_UV= signal_motion./2;
motion_vectors_all_UV = floor( motion_vectors_all_UV);
quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
signal_Temp_runlevel = signal_runlevel(:,1);
EOB=find(signal_Temp_runlevel == -1);
[r s]=size(EOB); 
blocknumber=(width * height)/(transform_blocksize*transform_blocksize);

signal_Temp_runlevel_U = signal_runlevel_U(:,1);
EOB_U=find(signal_Temp_runlevel_U == -1);
[r_U s_U]=size(EOB_U); 
blocknumber_U=(width/2 * height/2)/(transform_blocksize_UV*transform_blocksize_UV);

signal_Temp_runlevel_V = signal_runlevel_V(:,1);
EOB_V=find(signal_Temp_runlevel_V == -1);
[r_V s_V]=size(EOB_V); 
blocknumber_V=(width/2 * height/2)/(transform_blocksize_UV*transform_blocksize_UV);

for p=blocknumber:blocknumber:r   
    if(p == blocknumber)
        zigzag_scanned = blockbased_decoding_from_runlevel_representation(signal_runlevel(1:EOB(p),:), transform_blocksize);
        temp_quantisation_image = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
        temp_quantized_image =blockbased_dequantizer_from_levels(temp_quantisation_image, quantisation_matrix);
        temp_idct_reversed_output_image = blockbased_idct_on_image (temp_quantized_image , transform_blocksize);
        temp_idct_reversed_output_image(temp_idct_reversed_output_image<0)=0;
        temp_idct_reversed_output_image(temp_idct_reversed_output_image>1)=1;
        frame_buffer = temp_idct_reversed_output_image;
        
        zigzag_scanned_U = blockbased_decoding_from_runlevel_representation(signal_runlevel_U(1:EOB_U(p),:), transform_blocksize_UV);
        temp_quantisation_image_U = blockbased_decoding_from_zigzag_scanned(zigzag_scanned_U, transform_blocksize_UV, width/2, height/2);
        temp_quantized_image_U =blockbased_dequantizer_from_levels(temp_quantisation_image_U, quantisation_matrix);
        temp_idct_reversed_output_image_U = blockbased_idct_on_image (temp_quantized_image_U , transform_blocksize_UV);
        temp_idct_reversed_output_image_U(temp_idct_reversed_output_image_U<0)=0;
        temp_idct_reversed_output_image_U(temp_idct_reversed_output_image_U>1)=1; 
        frame_buffer_U = temp_idct_reversed_output_image_U;
        
        zigzag_scanned_V = blockbased_decoding_from_runlevel_representation(signal_runlevel_V(1:EOB_V(p),:), transform_blocksize_UV);
        temp_quantisation_image_V = blockbased_decoding_from_zigzag_scanned(zigzag_scanned_V, transform_blocksize_UV, width/2, height/2);
        temp_quantized_image_V =blockbased_dequantizer_from_levels(temp_quantisation_image_V, quantisation_matrix);
        temp_idct_reversed_output_image_V = blockbased_idct_on_image (temp_quantized_image_V , transform_blocksize_UV);
        temp_idct_reversed_output_image_V(temp_idct_reversed_output_image_V<0)=0;
        temp_idct_reversed_output_image_V(temp_idct_reversed_output_image_V>1)=1;
        frame_buffer_V = temp_idct_reversed_output_image_V;
        
        retval_V = yuv_write_one_frame(decoded_yuv_file,p/blocknumber, temp_idct_reversed_output_image, temp_idct_reversed_output_image_U,temp_idct_reversed_output_image_V);
         retval_V = yuv_write_one_frame('rs.yuv',p/blocknumber, temp_idct_reversed_output_image, temp_idct_reversed_output_image_U,temp_idct_reversed_output_image_V);
    else
        zigzag_scanned = blockbased_decoding_from_runlevel_representation( signal_runlevel(EOB(p-blocknumber)+1:EOB(p),:), transform_blocksize );
        temp_quantisation_image = blockbased_decoding_from_zigzag_scanned( zigzag_scanned, transform_blocksize, width, height );
        temp_quantized_image = blockbased_dequantizer_from_levels( temp_quantisation_image , quantisation_matrix );
        temp_idct_reversed_output_image = blockbased_idct_on_image( temp_quantized_image , transform_blocksize );
        inter_predicted_frame =  blockbased_motion_compensation(frame_buffer,transform_blocksize,me_searchrange,signal_motion((p-2*blocknumber)+1:(p-blocknumber),:));
        temp_idct_reversed_output_image = temp_idct_reversed_output_image + inter_predicted_frame;
        temp_idct_reversed_output_image(temp_idct_reversed_output_image<0)=0;
        temp_idct_reversed_output_image(temp_idct_reversed_output_image>1)=1; 
        frame_buffer = temp_idct_reversed_output_image;
        
        zigzag_scanned_U = blockbased_decoding_from_runlevel_representation( signal_runlevel_U(EOB_U(p-blocknumber)+1:EOB_U(p),:), transform_blocksize_UV );
        temp_quantisation_image_U = blockbased_decoding_from_zigzag_scanned( zigzag_scanned_U, transform_blocksize_UV, width/2, height /2);
        temp_quantized_image_U = blockbased_dequantizer_from_levels( temp_quantisation_image_U , quantisation_matrix );
        temp_idct_reversed_output_image_U = blockbased_idct_on_image( temp_quantized_image_U , transform_blocksize_UV );
        inter_predicted_frame_U =  blockbased_motion_compensation(frame_buffer_U,transform_blocksize_UV,me_searchrange_UV,motion_vectors_all_UV((p-2*blocknumber)+1:(p-blocknumber),:));
        temp_idct_reversed_output_image_U = temp_idct_reversed_output_image_U + inter_predicted_frame_U;
        temp_idct_reversed_output_image_U(temp_idct_reversed_output_image_U<0)=0;
        temp_idct_reversed_output_image_U(temp_idct_reversed_output_image_U>1)=1;
        frame_buffer_U = temp_idct_reversed_output_image_U; 
        
        zigzag_scanned_V = blockbased_decoding_from_runlevel_representation( signal_runlevel_V(EOB_V(p-blocknumber)+1:EOB_V(p),:), transform_blocksize_UV );
        temp_quantisation_image_V = blockbased_decoding_from_zigzag_scanned( zigzag_scanned_V, transform_blocksize_UV, width/2, height/2 );
        temp_quantized_image_V = blockbased_dequantizer_from_levels( temp_quantisation_image_V , quantisation_matrix );
        temp_idct_reversed_output_image_V = blockbased_idct_on_image( temp_quantized_image_V , transform_blocksize_UV );
        inter_predicted_frame_V =  blockbased_motion_compensation(frame_buffer_V,transform_blocksize_UV,me_searchrange_UV,motion_vectors_all_UV((p-2*blocknumber)+1:(p-blocknumber),:));
        temp_idct_reversed_output_image_V = temp_idct_reversed_output_image_V + inter_predicted_frame_V;
        temp_idct_reversed_output_image_V(temp_idct_reversed_output_image_V<0)=0;
        temp_idct_reversed_output_image_V(temp_idct_reversed_output_image_V>1)=1;
        frame_buffer_V = temp_idct_reversed_output_image_V;
        
         retval_V = yuv_write_one_frame(decoded_yuv_file,p/blocknumber,temp_idct_reversed_output_image,temp_idct_reversed_output_image_U,temp_idct_reversed_output_image_V);  
        retval_V = yuv_write_one_frame('rs.yuv',p/blocknumber,temp_idct_reversed_output_image,temp_idct_reversed_output_image_U,temp_idct_reversed_output_image_V);  

    end
end

    


