clear

% Read image
i = imread('Original.jpg');

% Convert uint8 to double
d = im2double(i);

% Create low-pass filter
h = fspecial('average', [3, 3]);

% Apply filter
filtered = imfilter(d, h, 'replicate');
croped = filtered(1:2:359, 1:2:479);

% Plot original and filtered image
%%{
subplot(2, 2, 1);
subimage(d);
subplot(2, 2, 2);
subimage(croped);
%}

% Inserting zeros
newd = zeros(359, 479);
for i = 1:180
    for j = 1:240
        newd(2 * i - 1, 2 * j - 1) = croped(i, j);
    end
end

% Create low-pass filter
h2 = [0.25, 0.5, 0.25;
    0.5, 1, 0.5;
    0.25, 0.5, 0.25];

% Apply filter
filtered2 = imfilter(newd, h2);

% Plot low resolution and filtered image
%%{
subplot(2, 2, 3);
subimage(newd);
subplot(2, 2, 4);
subimage(filtered2);
%}

mse = sum(sum((d - filtered2).^2)) / (size(d, 1) * size(d, 2));
display(mse);

psnr = 10 * log10(1^2 / mse);
display(psnr);
