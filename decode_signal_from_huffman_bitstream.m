function [bitstream signal] = decode_signal_from_huffman_bitstream(bitstream, huffman_table, nr_of_symbols)
if nargin < 3
    nr_of_symbols = Inf;
end
nr_of_huffman_entries = size (huffman_table,1);
min_bits = 0;
max_bits = 0;
for i=1:nr_of_huffman_entries
    [Temp,huffman_length_nr] = size (huffman_table{i,1});
    if (i == 1)
        min_bits = huffman_length_nr;
        max_bits = huffman_length_nr;
    end
    if (huffman_length_nr < min_bits)
        min_bits = huffman_length_nr;
    end
    if (huffman_length_nr > max_bits)
        max_bits = huffman_length_nr;
    end
    huffman_length(i,1) = huffman_length_nr;
end
signal = [];
for i=1:nr_of_symbols
    symbol_found = false;
    current_nr_of_bits = min_bits;
        while ((current_nr_of_bits) <= max_bits & (symbol_found == false))
            [this_huffman new_bitstream] = bitstream_read_bits(bitstream,current_nr_of_bits);     
            if (isempty(this_huffman) == 1)
                 break;       
            elseif(isempty(this_huffman) == 0) 
                        for  symbol_row = find (huffman_length == current_nr_of_bits)
                            [p,q] = size (symbol_row);
                              for r = 1:p
                                if (huffman_table{symbol_row(r,1),1} == this_huffman)
                                                        signal(i,:)=huffman_table{symbol_row(r,1),2};
                                                        bitstream=new_bitstream ;
                                                        symbol_found = true;
                                                     break;
                                             end 
                                   end
                       current_nr_of_bits = current_nr_of_bits + 1; 
                        end
            end   
        end
        
        if (symbol_found == false)
            break; 
        end
        
end
%bitstream_signal = signal;
[m,n] = size (signal);
if (nr_of_symbols > m)
fprintf('Error:\n');
end
