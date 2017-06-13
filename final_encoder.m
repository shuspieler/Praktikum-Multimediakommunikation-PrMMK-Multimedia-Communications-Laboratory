function final_encoder(input_sequence_yuv, coded_file, width, height, nr_of_frame, qp)
[coded_bits, mse_per_frame] = encoder_basic(input_sequence_yuv,coded_file,width, height, nr_of_frame,8,8,8,8);
