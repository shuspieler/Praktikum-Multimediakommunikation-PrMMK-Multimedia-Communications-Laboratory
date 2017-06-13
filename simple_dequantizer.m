function output_image = simple_dequantizer(quant_levels,quantizer_stepsize)
[m,n] = size (quant_levels);
for i = 1:m
    for j =1:n
        Temp(i,j) = quant_levels(i,j)*quantizer_stepsize;
    end
end
output_image = Temp;