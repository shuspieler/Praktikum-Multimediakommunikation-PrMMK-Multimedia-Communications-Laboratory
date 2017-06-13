function output_image = scalar_dequantizer(input_levels,quantizer_matrix)
[m,n] = size (input_levels);
for i = 1:m
    for j = 1:n
        Temp(i,j) = input_levels(i,j).*quantizer_matrix(i,j);
    end
end
output_image = Temp;
