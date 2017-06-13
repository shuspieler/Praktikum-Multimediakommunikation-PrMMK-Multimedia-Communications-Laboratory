function [bitstream] = encode_signal_to_huffman_bitstream(bitstream,huffman_table, signal)
[m,n] = size( huffman_table ); 
    for i=1:m
        huffman_table_lookup(i,:) = huffman_table{i,n}; 
    end
[m n]=size(signal);
for idx=1:m
    find_col1=find(huffman_table_lookup(:,1)==signal(idx,1));
    find_col2=find(huffman_table_lookup(find_col1,2)==signal(idx,2));
    position_in_huffman_table=find_col1(find_col2);
    bitstream=bitstream_append_bits(bitstream,huffman_table{position_in_huffman_table,1});
end
