function [coded_bits, mse_per_frame]=encoder_basic(input_yuv_file, coded_file, width, height, number_of_frames, transform_blocksize, qp, me_blocksize, me_searchrange)
motion_vectors_all = []; transform_blocksize_UV = transform_blocksize/2; me_blocksize_UV = me_blocksize/2; me_searchrange_UV = me_searchrange/2;
quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
for i = 1 : number_of_frames
    [output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame(input_yuv_file, i , width, height);
    if (i == 1 )        % I-frame
      temp_dct_image = blockbased_dct_on_image(output_image_Y, transform_blocksize);     
      temp_out_levels = blockbased_quantizer_to_levels(temp_dct_image, quantisation_matrix);
      zigzag_scanned = blockbased_encoding_to_zigzag_scanned(temp_out_levels,transform_blocksize);
      runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);
       intra_inverse_quantisation_matrix= blockbased_dequantizer_from_levels(temp_out_levels , quantisation_matrix);
       inverse_transform = blockbased_idct_on_image (intra_inverse_quantisation_matrix , transform_blocksize); 
      inverse_transform(inverse_transform<0)=0;
      inverse_transform(inverse_transform>1)=1;
      mse(1,i)=mse_of_frame(output_image_Y,inverse_transform);
      frame_buffer = inverse_transform;      
    else             %P-frames
      motion_vectors = blockbased_motion_search (output_image_Y, frame_buffer, transform_blocksize, me_searchrange );
      motion_vectors_all = [motion_vectors_all; motion_vectors];
      preddicted_frame = blockbased_motion_compensation(frame_buffer,transform_blocksize,me_searchrange,motion_vectors);
      difference_frame = output_image_Y-preddicted_frame;     
      temp_inter_dct_image = blockbased_dct_on_image(difference_frame, transform_blocksize);
      temp_inter_out_levels = blockbased_quantizer_to_levels(temp_inter_dct_image, quantisation_matrix);
      temp_inter_zigzag_scanned = blockbased_encoding_to_zigzag_scanned(temp_inter_out_levels,transform_blocksize);
      predicted_runlevel_representation = blockbased_encoding_to_runlevel_representation(temp_inter_zigzag_scanned);
      runlevel_representation = [runlevel_representation ; predicted_runlevel_representation];   
      inter_inverse_quantisation_matrix= blockbased_dequantizer_from_levels(temp_inter_out_levels, quantisation_matrix);
      inverse_transform = blockbased_idct_on_image (inter_inverse_quantisation_matrix, transform_blocksize);
      inverse_transform= preddicted_frame+inverse_transform;
      inverse_transform(inverse_transform<0)=0;output_image_Y
      inverse_transform(inverse_transform>1)=1;
      frame_buffer = inverse_transform;
      mse(1,i)=mse_of_frame(output_image_Y, inverse_transform);
    end
end

motion_vectors_all_UV =  motion_vectors_all./2;
motion_vectors_all_UV = floor( motion_vectors_all_UV);

for i = 1 : number_of_frames
    [output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame(input_yuv_file, i , width, height);
    if (i == 1 )        % I-frame
        
      temp_dct_image_U = blockbased_dct_on_image(output_image_U, transform_blocksize_UV);     
      temp_out_levels_U = blockbased_quantizer_to_levels(temp_dct_image_U, quantisation_matrix);
      zigzag_scanned_U = blockbased_encoding_to_zigzag_scanned(temp_out_levels_U,transform_blocksize_UV);
      runlevel_representation_U = blockbased_encoding_to_runlevel_representation(zigzag_scanned_U);
       intra_inverse_quantisation_matrix_U= blockbased_dequantizer_from_levels(temp_out_levels_U , quantisation_matrix);
      inverse_transform_U = blockbased_idct_on_image (intra_inverse_quantisation_matrix_U , transform_blocksize_UV); 
      inverse_transform_U(inverse_transform_U<0)=0;
      inverse_transform_U(inverse_transform_U>1)=1;
      mse(1,i)=mse_of_frame(output_image_U,inverse_transform_U);
      frame_buffer_U = inverse_transform_U;
      
      temp_dct_image_V = blockbased_dct_on_image(output_image_V, transform_blocksize_UV);     
      temp_out_levels_V = blockbased_quantizer_to_levels(temp_dct_image_V, quantisation_matrix);
      zigzag_scanned_V = blockbased_encoding_to_zigzag_scanned(temp_out_levels_V,transform_blocksize_UV);
      runlevel_representation_V = blockbased_encoding_to_runlevel_representation(zigzag_scanned_V);
       intra_inverse_quantisation_matrix_V= blockbased_dequantizer_from_levels(temp_out_levels_V , quantisation_matrix);
      inverse_transform_V = blockbased_idct_on_image (intra_inverse_quantisation_matrix_V , transform_blocksize_UV); 
      inverse_transform_V(inverse_transform_V<0)=0;
      inverse_transform_V(inverse_transform_V>1)=1;
      mse(1,i)=mse_of_frame(output_image_V,inverse_transform_V);
      frame_buffer_V = inverse_transform_V;
      
    else             %P-frames
      
          preddicted_frame_U = blockbased_motion_compensation(frame_buffer_U,transform_blocksize_UV,me_searchrange_UV,motion_vectors_all_UV);
          difference_frame_U = output_image_U-preddicted_frame_U;     
          temp_inter_dct_image_U = blockbased_dct_on_image(difference_frame_U, transform_blocksize_UV);
          temp_inter_out_levels_U = blockbased_quantizer_to_levels(temp_inter_dct_image_U, quantisation_matrix);
          temp_inter_zigzag_scanned_U = blockbased_encoding_to_zigzag_scanned(temp_inter_out_levels_U,transform_blocksize_UV);
          predicted_runlevel_representation_U = blockbased_encoding_to_runlevel_representation(temp_inter_zigzag_scanned_U);
          runlevel_representation_U = [runlevel_representation_U ; predicted_runlevel_representation_U];   
          inter_inverse_quantisation_matrix_U= blockbased_dequantizer_from_levels(temp_inter_out_levels_U, quantisation_matrix);
          inverse_transform_U = blockbased_idct_on_image (inter_inverse_quantisation_matrix_U, transform_blocksize_UV);
          inverse_transform_U= preddicted_frame_U+inverse_transform_U;
          inverse_transform_U(inverse_transform_U<0)=0;
          inverse_transform_U(inverse_transform_U>1)=1;
          frame_buffer_U = inverse_transform_U;
          mse(1,i)=mse_of_frame(output_image_U, inverse_transform_U);
          
          preddicted_frame_V = blockbased_motion_compensation(frame_buffer_V,transform_blocksize_UV,me_searchrange_UV,motion_vectors_all_UV);
          difference_frame_V = output_image_V-preddicted_frame_V;     
          temp_inter_dct_image_V = blockbased_dct_on_image(difference_frame_V, transform_blocksize_UV);
          temp_inter_out_levels_V = blockbased_quantizer_to_levels(temp_inter_dct_image_V, quantisation_matrix);
          temp_inter_zigzag_scanned_V = blockbased_encoding_to_zigzag_scanned(temp_inter_out_levels_V,transform_blocksize_UV);
          predicted_runlevel_representation_V = blockbased_encoding_to_runlevel_representation(temp_inter_zigzag_scanned_V);
          runlevel_representation_V = [runlevel_representation_V ; predicted_runlevel_representation_V];   
          inter_inverse_quantisation_matrix_V= blockbased_dequantizer_from_levels(temp_inter_out_levels_V, quantisation_matrix);
          inverse_transform_V = blockbased_idct_on_image (inter_inverse_quantisation_matrix_V, transform_blocksize_UV);
          inverse_transform_V= preddicted_frame_V+inverse_transform_V;
          inverse_transform_V(inverse_transform_V<0)=0;
          inverse_transform_V(inverse_transform_V>1)=1;
          frame_buffer_V = inverse_transform_V;
          mse(1,i)=mse_of_frame(output_image_V, inverse_transform_V);
    end
end

huffman_table_runlevel_difference_frame = create_huffman_table_from_signal(runlevel_representation);
huffman_table_motion_vectors_all = create_huffman_table_from_signal(motion_vectors_all);
bitstream_runlevel_difference_frame = bitstream_init();
bitstream_motion_vectors_all = bitstream_init();
[bitstream_runlevel_difference_frame] = encode_signal_to_huffman_bitstream(bitstream_runlevel_difference_frame, huffman_table_runlevel_difference_frame, runlevel_representation);
[bitstream_motion_vectors_all] = encode_signal_to_huffman_bitstream(bitstream_motion_vectors_all , huffman_table_motion_vectors_all, motion_vectors_all);

huffman_table_runlevel_difference_frame_U = create_huffman_table_from_signal(runlevel_representation_U);
bitstream_runlevel_difference_frame_U = bitstream_init();
[bitstream_runlevel_difference_frame_U] = encode_signal_to_huffman_bitstream(bitstream_runlevel_difference_frame_U, huffman_table_runlevel_difference_frame_U, runlevel_representation_U);

huffman_table_runlevel_difference_frame_V = create_huffman_table_from_signal(runlevel_representation_V);
bitstream_runlevel_difference_frame_V = bitstream_init();
[bitstream_runlevel_difference_frame_V] = encode_signal_to_huffman_bitstream(bitstream_runlevel_difference_frame_V, huffman_table_runlevel_difference_frame_V, runlevel_representation_V);

save (coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table_runlevel_difference_frame', 'huffman_table_runlevel_difference_frame_U','huffman_table_runlevel_difference_frame_V','huffman_table_motion_vectors_all' ,'bitstream_runlevel_difference_frame','bitstream_runlevel_difference_frame_U','bitstream_runlevel_difference_frame_V','bitstream_motion_vectors_all','me_searchrange');
coded_bits=bitstream_get_length(bitstream_runlevel_difference_frame)+bitstream_get_length(bitstream_runlevel_difference_frame_U)+bitstream_get_length(bitstream_runlevel_difference_frame_V)+bitstream_get_length(bitstream_motion_vectors_all);
mse_per_frame = mse; %Error 