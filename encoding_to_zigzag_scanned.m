function zigzag_scanned = encoding_to_zigzag_scanned(input_image)
[m,n] = size (input_image);
Temp = [];
permutation_matrix = generate_zigzag_permutation_matrix(n,m);
for i = 1 : m*n
    [j,k] = find(permutation_matrix == i);
    Temp(i) = input_image(j,k);
end
zigzag_scanned = Temp;

            