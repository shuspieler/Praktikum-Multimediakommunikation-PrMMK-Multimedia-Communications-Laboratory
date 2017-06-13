function quant_levels = simple_quantizer(input_image,quantizer_stepsize)
[m,n] = size (input_image);
for i = 1:m
    for j= 1:n
        Temp(i,j) = round (input_image(i,j)/quantizer_stepsize);
    end
end
quant_levels = Temp;
        
