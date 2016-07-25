clear

i = imread('Lena.gif');
d = im2double(i);
%imshow(i);

subplot(2, 2, 1);
subimage(d);

lpf = ones(5, 5) / 25;

d = imfilter(d, lpf);
subplot(2, 2, 2);
subimage(d);

hpf = [1, 1, 1;
    1, -9, 1;
    1, 1, 1];
edges = imfilter(d, hpf);

%{
sharpened = ifft2(fft2(edges) + fft2(d));
D = fft2(d);
EDGES = fft2(edges);
subplot(2, 2, 3);
imshow(EDGES + D);
subplot(2, 2, 4);
imshow(ifft2(EDGES + D));
%}

D = fft2(d);

blurred = imfilter(d, lpf);
subplot(2, 2, 2);
imshow(blurred);
BLURRED = fft2(blurred);

MASK = D - BLURRED;
subplot(2, 2, 3);
imshow(ifft2(MASK));
SHARPENNED = D + 2 * MASK;
subplot(2, 2, 4);
imshow(ifft2(SHARPENNED));