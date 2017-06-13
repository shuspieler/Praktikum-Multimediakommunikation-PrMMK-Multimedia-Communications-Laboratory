function permutation_matrix = generate_zigzag_permutation_matrix(width,height)
M = height; N = width;Zigzag = [1]; i = 1; j =1; s=1; f1 = 0; f2 = 0;
while (i<=M & j<=N)
     while (((i -1 ==0)||i == M) & j<N )
        s = s+1;
        j = j+1;
        Zigzag(i,j) = s;
        f1 = 0; f2 = 0;
        break;
     end
     while (j - 1 > 0 & i < M & f2 == 0)
        s = s+1;
        i = i+1;
        j = j-1;
        f1 = 1;
        Zigzag(i,j) = s;
     end
     while (((j-1 == 0)||j == N) & i<M )
        s = s+1;
        i = i+1;
        Zigzag(i,j) = s;
        f1 = 0; f2 = 0;
        break;
     end
     while (i - 1 > 0 & j < N & f1 == 0)
        s = s+1;
        i = i-1;
        j = j+1;
        f2 = 1;
        Zigzag(i,j) = s;
     end
     if (i == M & j == N)
        break;
    end
end
permutation_matrix = Zigzag;