function image_restored = cls_restoration(image_noisy, psf, alpha)

%% find proper dimension for frequency-domain processing
[image_height, image_width] = size(image_noisy);
[psf_height, psf_width] = size(psf);
dim = max([image_width, image_height, psf_width, psf_height]);
dim = next2pow(dim);

%% frequency-domain representation of degradation
psf = padarray(psf, [dim - psf_height, dim - psf_width], 'post');
psf = circshift(psf, [-(psf_height - 1) / 2, -(psf_width - 1) / 2]);
H = fft2(psf, dim, dim);

%% frequency-domain representation of Laplace operator
Laplace = [0, -0.25, 0; -0.25, 1, -0.25; 0, -0.25, 0];
Laplace = padarray(Laplace, [dim - 3, dim - 3], 'post');
Laplace = circshift(Laplace, [-1, -1]);
C = fft2(Laplace, dim, dim);

%% Frequency response of the CLS filter
% Refer to the lecture for frequency response of CLS filter
% Complete the implementation of the CLS filter by uncommenting the
% following line and adding appropriate content

R = conj(H) ./ (abs(H).^2 + alpha * abs(C).^2);
%display(R);

%% CLS filtering
Y = fft2(image_noisy, dim, dim);
image_restored_frequency = R .* Y;
image_restored = ifft2(image_restored_frequency);
image_restored = image_restored(1 : image_height, 1 : image_width);