function output_mse=mse_of_frame(original_image,distorted_image)
[X,Y] = size (original_image);
MSE = 0;
for i = 1:X
    for j = 1:Y
        MSE =  MSE + (original_image(i,j)-distorted_image(i,j)).^2;
    end
end
output_mse = (MSE / (X*Y));