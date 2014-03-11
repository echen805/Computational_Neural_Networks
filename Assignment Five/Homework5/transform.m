function [ new_output ] = transform( output )
% transforms the vector to only contain the dominant term
for a=1:20
    dominant = abs(output(1,a));
    dominant_pos = 1;
    for b=2:4
        if dominant < abs(output(b,a))
           dominant = abs(output(b,a));
           output(dominant_pos,a) = 0;
           dominant_pos = b;
        else
            output(b,a) = 0;
        end
    end
end
new_output = output;
end

