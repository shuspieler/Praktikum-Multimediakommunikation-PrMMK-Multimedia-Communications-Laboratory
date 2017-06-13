1. myfun: y(x,c) = x^c;
2. yuv_read_one_frame: Reading a single frame from an yuv input data stream of size width*height. The image_number in the sequence is starting at 1.
3. yuv_write_one_frame: write one YCbCr-(YUV-)frame into a file;
4. plot_geometries(Cell_array): plot each of the two-dimensional geometrical objects(point, line, triangle, rectangle) in Cell_array in its own window!
5. huffman_table = create_huffman_table_from_signal(input_signal): creates a probability table based on the occurrence probabilities of the input_signal symbols.
6. huffman_table = create_huffman_table_from_probability(par_probability_matrix): creates the Huffman table with the help of the probability table; P.39
7. [bitstream] = encode_signal_to_huffman_bitstream(bitstream, huffman_table, signal): stores the Huffman code words in a bitstream. P.44;
8. [bitstream signal] = decode_signal_from_huffman_bitstream(bitstream, huffman_table, nr_of_symbols): P.45;
9. output_mse = mse_of_frame(original_image,distorted_image): returnthe MSE(mean squared error) as a result. P.51;
10.output_psnr = psnr_of_frame(original_image,distorted_image): returns the PSNR value as a result. P.51;
11.quant_levels = simple_quantizer(input_image, quantizer_stepsize): returns the quantization levels i of an input image with respect to the quantization step size Q. P.55;
12.output_image = simple_dequantizer(quant_levels, quantizer_stepsize):reconstruct the original values v from the quantization levels i according to equation.
13.output_levels = scalar_quantizer(input_image, quantizer_matrix): compute the quantization levels of an image, given a quantization matrix. P.57;
14.output_levels = scalar_dequantizer(input_image, quantizer_matrix): reconstruct the original image from the quantization levels and the quantization matrix. ;
15.out_levels = blockbased_quantizer_to_levels(input_image, quantizer_matrix): implement block-based quantization and de-quantization for square blocks of dimension blocksize^2;
16.out_image = blockbased_dequantizer_from_levels(input_levels, quantizer_matrix);
17.sad_value = calculate_sad(input_block1, input_block2): compute the SAD(sum of absolute differences) of two blocks. P69;
18.motion_vector = get_motion_vector_for_block(padded_input_image, padded_previous_image, blockstart_x, blockstart_y, blocksize, searchange): determine the optimal motion vector for a given image block;
19.motion_vectors = blockbased_motion_search(input_image, previous_image, blocksize, searchrange): compute the motion vectors for a whole frame.P.72;
20.output_image = blockbased_motion_compensation(input_image, blocksize, searchrange, motion_vectors): compute the motion of the image. P72;
21.output_image = blockbased_dct_on_image(input_image, blocksize): DCT(Discrete Cosine Transform);
22.output_image = blockbased_idct_on_image(input_image, blocksize);
23.permutation_matrix = generate_zigzag_permutation_matrix(width, height): build a permutation matrix of size[M*N];
24.zigzag_scanned = encoding_to_zigzag_scanned(input_image): transform the block input_image of size [height*width] into the 1* MN vector zigzag_scanned via a zigzag scan;
25.output_image = decoding_from_zigzag_scanned(zigzag_scanned, width, height): transform the input vector zigzag_scanned into the image output_image that it is based on;
26.zigzag_scanned = blockbased_encoding_to_zigzag_scanned(input_image,blocksize):P.92
27.output_image = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, blocksize, width, height);
28.runlevel_representation = encoding_to_runlevel_representation(input_vector): transform input_vector into its run-level representation;
29.output_vector = decoding_from_runlevel_representation(runlevel_representation, blocksize);
30.runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);
31.zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation, blocksize);