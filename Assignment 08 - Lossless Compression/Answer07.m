clear;

i = imread('Cameraman256.bmp');

prob = imhist(i) / (size(i, 1) * size(i, 2));

entropy = sum(-log2(prob) .* prob);

display(entropy);