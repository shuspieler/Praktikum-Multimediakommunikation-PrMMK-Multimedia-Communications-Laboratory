function output_psnr=psnr_of_frame(original_image,distorted_image)
PSER = 10*log10(1/mse_of_frame(original_image,distorted_image));
output_psnr = PSER;
