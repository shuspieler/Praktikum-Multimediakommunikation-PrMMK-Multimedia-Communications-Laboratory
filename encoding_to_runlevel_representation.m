function runlevel_representation = encoding_to_runlevel_representation(input_vector)
[m,n] = size (input_vector);
Temp_runlevel_representation = []; run_step = 0; level_step = 0;
for i = 1 : n
    if (input_vector(m,i) ~= 0 )
        level_step = level_step + 1;
        Temp_runlevel_representation(level_step,1:2) = [run_step,input_vector(1,i)];
        run_step = 0;
    else
        run_step = run_step + 1;
    end
end
runlevel_representation = Temp_runlevel_representation;
    