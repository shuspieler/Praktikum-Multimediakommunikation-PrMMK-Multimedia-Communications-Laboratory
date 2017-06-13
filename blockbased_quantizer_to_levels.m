function out_levels = blockbased_quantizer_to_levels(input_image,quantizer_matrix)
[m,n] = size (quantizer_matrix);
out_levels = blkproc(input_image,[m,n],@(input_image) scalar_quantizer(input_image,quantizer_matrix));
end
