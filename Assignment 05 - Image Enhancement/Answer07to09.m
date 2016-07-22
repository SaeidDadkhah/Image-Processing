clear

% Read image
in = imread('Noisy.jpg');
inf = imread('Noise-free.jpg');

% Convert uint8 to double
dn = im2double(in);
dnf = im2double(inf);

% Calculate PSNR of noise-free and noisy image
mse = sum(sum((dnf - dn).^2)) / (size(dnf, 1) * size(dnf, 2));
display(mse);

psnr = 10 * log10(1^2 / mse);
display(psnr);

% Plot images
subplot(2, 2, 1);
subimage(dn);
subplot(2, 2, 2);
subimage(dnf);

% Pass 1
filtered = medfilt2(dn);
subplot(2, 2, 3);
subimage(filtered);

% Calculate PSNR of noise-free and 1-pass image
mse = sum(sum((dnf - filtered).^2)) / (size(dnf, 1) * size(dnf, 2));
display(mse);

psnr = 10 * log10(1^2 / mse);
display(psnr);

% Pass 2
filtered2 = medfilt2(filtered);
subplot(2, 2, 4);
subimage(filtered2);

% Calculate PSNR of noise-free and 2-pass image
mse = sum(sum((dnf - filtered2).^2)) / (size(dnf, 1) * size(dnf, 2));
display(mse);

psnr = 10 * log10(1^2 / mse);
display(psnr);