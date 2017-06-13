function runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned)
[m , n] = size (zigzag_scanned); 
temp_runlevel_representation = [];
for i = 1 : m
    [p,q] = size (temp_runlevel_representation);
    a =  encoding_to_runlevel_representation(zigzag_scanned(i,:));
    [h,g] = size (a);
    temp_runlevel_representation(p+1:p+h,1:2) = a;
    temp_runlevel_representation(p+h+1,1:2) = [-1,-1];
end
runlevel_representation =  temp_runlevel_representation;
