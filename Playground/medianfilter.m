i = imread('Lena.gif');
subplot(2, 2, 1);
subimage(i);

noisy = imnoise(i,'salt & pepper',0.1);
subplot(2, 2, 2);
subimage(noisy);

f2d = medfilt2(noisy);
subplot(2, 2, 3);
subimage(f2d);

%f1d = medfilt1(noisy, 2, 1, 1);
%subplot(2, 2, 4);
%subimage(f1d);
