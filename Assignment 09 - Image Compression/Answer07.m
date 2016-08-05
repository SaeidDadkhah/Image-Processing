clear;

bmp_i = imread('Cameraman256.bmp');

imwrite(bmp_i, 'Cameraman256.jpg', 'jpg', 'quality', 10);

jpg_i = imread('Cameraman256.jpg');

bmp_d = im2double(bmp_i);
jpg_d = im2double(jpg_i);

mse = sum(sum((bmp_d - jpg_d) .^ 2)) / (size(bmp_d, 1) * size(bmp_d, 2));
display(mse);

psnr = 10 * log10(1^2 / mse);
display(psnr);