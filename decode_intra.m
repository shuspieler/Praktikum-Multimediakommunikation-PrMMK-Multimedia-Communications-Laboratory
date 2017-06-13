function decode_intra(coded_file,decoded_yuv_file)
load('coded_file')
[bitstream signal] = decode_signal_from_huffman_bitstream(bitstream, huffman_table);
quantisation_matrix = get_quantisation_matrix(qp, transform_blocksize);
zigzag_scanned = blockbased_decoding_from_runlevel_representation(signal, transform_blocksize);
%output_vector = decoding_from_runlevel_representation(bitstream, transform_blocksize);
%zigzag_scanned = blockbased_decoding_from_runlevel_representation(zigzag_scanned, transform_blocksize);
out_image = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
out_put_image = blockbased_dequantizer_from_levels(out_image , quantisation_matrix);
output_image = blockbased_idct_on_image (out_put_image , transform_blocksize);
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
retval = yuv_write_one_frame( decoded_yuv_file,1,output_image);


