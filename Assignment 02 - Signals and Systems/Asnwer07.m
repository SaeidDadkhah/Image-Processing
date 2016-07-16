clear

% Read image
i = imread('Lena.gif');

% Convert uint8 to double
d = im2double(i);

% Create low-pass filter
h = fspecial('average', [3, 3]);

% Apply filter
filtered = imfilter(d, h, 'replicate');

% Plot original and filtered image
%{
subplot(1, 2, 1);
subimage(d);
subplot(1, 2, 2);
subimage(filtered);
%}

mse = sum(sum((d - filtered).^2)) / (size(d, 1) * size(d, 2));
display(mse);

psnr = 10 * log10(1^2 / mse);
display(psnr);