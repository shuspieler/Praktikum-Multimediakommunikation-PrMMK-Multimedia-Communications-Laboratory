function  huffman_table=create_huffman_table_from_signal(input_signal)
[unique_symbols,y,z]= unique(input_signal,'rows');
[M,N] = size (input_signal);
[m,n] = size (unique_symbols);
symbol_count = zeros(size(unique_symbols,1),1);
for i=1:m
    for j=1:n
        symbol_count(i,j+1)=unique_symbols(i,j);
    end
end
for i=1:m
    k=0;
    for j= 1:M
        if(z(j)==i)
            k=k+1;
        end
        symbol_count(i,1)=k/M;
    end
end
huffman_table = create_huffman_table_from_probability(symbol_count);
            




    
    
    
    
