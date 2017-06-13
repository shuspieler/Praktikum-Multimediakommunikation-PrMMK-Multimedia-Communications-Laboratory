%%
%P-1
P = [0.01 0.15 0.05 0.2 0.02 0.02 0.05 0.5]
H = 0
for i=1:8
     H = H - P(i)*log2(P(i))
end
%%
%P-2
P1= sort(P)
HL=0
for i=1:8 %??????1?9???
    HL=HL + i*P1(9-i) 
end
%%
%P-3
-12*(12/22)*log2(12/22)-2*(2/22)*log2(2/22)-4*(4/22)*log(4/22)-2*2/22*log2(2/22)-1/22*log2(1/22)-1/22*log(1/22)
%%
%E-1
input_signal = [244 244;
                245 244;
                243 244;
                243 244;
                244 244;
                243 244;
                244 244;
                245 244;
                243 244;
                242 242;
                240 241]

probability_matrix= create_huffman_table_from_signal(input_signal)
%%
%E-2
huffman_table = create_huffman_table_from_probability(probability_matrix)
show_huffman_table(huffman_table)
%%
%E-3

%%
load ('huffman_table.mat');
load('input_signal_huffman.mat')
Ergebnis = create_huffman_table_from_signal(input_signal);
show_huffman_table(Ergebnis);

