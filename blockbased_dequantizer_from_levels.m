function out_image = blockbased_dequantizer_from_levels(input_levels,quantizer_matrix)
[m,n] = size (quantizer_matrix);
out_image = blkproc (input_levels,[m,n],@(input_image) scalar_dequantizer(input_image,quantizer_matrix));
end