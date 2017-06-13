function [coded_bits, mse_per_frame]=encoder_basic_intra(input_yuv_file, coded_file, width, height,number_of_frames,transform_blocksize, qp)
runlevel_representation_all= [];mse = [];
quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
for frame_number = 1:number_of_frames
[output_image_Y, output_image_U, output_image_V] = yuv_read_one_frame(input_yuv_file,frame_number,width, height);
temp_dct_output_image = blockbased_dct_on_image(output_image_Y, transform_blocksize);
temp_out_levels = blockbased_quantizer_to_levels(temp_dct_output_image, quantisation_matrix)
zigzag_scanned = blockbased_encoding_to_zigzag_scanned(temp_out_levels,transform_blocksize);
runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);
temp_inverse_code = blockbased_dequantizer_from_levels(temp_out_levels, quantisation_matrix);
reconstructed_image = blockbased_idct_on_image (temp_inverse_code , transform_blocksize);
reconstructed_image(reconstructed_image<0)=0
reconstructed_image(reconstructed_image>1)=1
%[m n]= size(runlevel_representation);
%runlevel_representation_all(end+(1:m),:) = runlevel_representation;
runlevel_representation_all = [runlevel_representation_all; runlevel_representation];
mse(1,frame_number)=mse_of_frame(output_image_Y,reconstructed_image);
end
huffman_table = create_huffman_table_from_signal(runlevel_representation_all);
bitstream = bitstream_init();
[bitstream] = encode_signal_to_huffman_bitstream(bitstream, huffman_table, runlevel_representation_all);
save (coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream');
coded_bits=bitstream_get_length(bitstream);
mse_per_frame = mse;