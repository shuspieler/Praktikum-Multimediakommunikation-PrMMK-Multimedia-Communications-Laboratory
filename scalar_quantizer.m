function output_levels = scalar_quantizer(input_image,quantizer_matrix)
[m,n] = size (input_image);
for i = 1:m
    for j = 1:n
        Temp(i,j) = round (input_image(i,j)./quantizer_matrix(i,j));
    end
end
output_levels = Temp;
