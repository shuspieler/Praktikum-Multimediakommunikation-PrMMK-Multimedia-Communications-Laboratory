function huffman_table = create_huffman_table_from_probability(par_probability_matrix)
[M,N] = size(par_probability_matrix);
sorted_probability_matrix = sortrows(par_probability_matrix);
nr_of_codewords = size (sorted_probability_matrix,1);
huffman_table = cell(nr_of_codewords,2);
for i=1:nr_of_codewords
    huffman_table{i,2}=[sorted_probability_matrix(i,2:N)];
end
huffman_tree = cell(nr_of_codewords,2);
for i=1:nr_of_codewords
    huffman_tree{i,1}=[sorted_probability_matrix(i,1)];
    huffman_tree{i,2}=i;
end
new_huffman_tree = huffman_tree;
show_huffman_tree(huffman_tree);
while (size(new_huffman_tree,1)>1)
%for i=1:size (new_huffman_tree,1)
    j = size (new_huffman_tree{1,2});
    j=j(1,1);
    for i=1:j
        huffman_table{new_huffman_tree{1,2}(i),1} = [1 huffman_table{new_huffman_tree{1,2}(i),1}];
    end
    j = size (new_huffman_tree{2,2});
    for i=1:j
        huffman_table{new_huffman_tree{2,2}(i),1} = [0 huffman_table{new_huffman_tree{2,2}(i),1}];
    end
    new_huffman_tree{1,1} = new_huffman_tree{1,1} + new_huffman_tree{2,1};
    new_huffman_tree{1,2} = [new_huffman_tree{1,2}; new_huffman_tree{2,2}];
    j = size (new_huffman_tree,1);
    for i=2:j
        if(i ~= j)
            new_huffman_tree(i,:)= new_huffman_tree(i+1,:);
        end
        if(i == j)
            new_huffman_tree(i,:) = [] ;
        end
    end
    new_huffman_tree = sortrows(new_huffman_tree,1);
end

        