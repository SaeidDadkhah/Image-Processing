function result = next2pow(input)
if input <= 0
    fprintf('Error: input must be positive!\n');
    result = -1;
else
    index = 0;
    while 2 ^ index < input
        index = index + 1;
    end
    result = 2 ^ index;
end