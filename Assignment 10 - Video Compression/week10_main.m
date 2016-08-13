clear all
close all

% load reference frame (frame_0) and target frame (frame_1)
frame_0 = double(imread('frame_0.jpg'));
frame_1 = double(imread('frame_1.jpg'));
[H, W] = size(frame_0);  % frame dimensions

%% book-keeping variables and parameters
blk_size = 16;  % block dimensions
num_blk_H = H / blk_size;  % number of blocks
num_blk_W = W / blk_size;
num_blk = num_blk_H * num_blk_W;
mv = zeros(num_blk, 2);  % "motion vectors", actually indices for matched blocks
residual = zeros(H, W);  % motion-compensated residual
dct_transform = zeros(H, W);  % DCT transformed residual
quantize_step = 10;  % simple uniform quantization
dct_quantized = zeros(H, W);  % quantized DCT transform
idct_transform = zeros(H, W);  % inverse DCT transform
reconstructed = zeros(H, W);  % reconstructed frame

%% loop over all blocks
for jj = 1 : num_blk_W
    for ii = 1 : num_blk_H
        fprintf('Encoding %d out of %d blocks\n', (jj - 1) * num_blk_H + ii, num_blk);
        range_vertical = (ii - 1) * blk_size + 1 : ii * blk_size;
        range_horizontal = (jj - 1) * blk_size + 1 : jj * blk_size;
        
        % target block to encode
        target_blk = frame_1(range_vertical, range_horizontal);
        
        % motion-compensation
        [ref_ii, ref_jj, residual_blk] = block_match(target_blk, frame_0);
        mv((jj - 1) * num_blk_H + ii, :) = [ref_ii, ref_jj];
        residual(range_vertical, range_horizontal) = residual_blk;
        
        % DCT of residual
        dct_transform_blk = dct2(residual_blk);
        dct_transform(range_vertical, range_horizontal) = dct_transform_blk;
        
        % quantization and de-quantization
        dct_quantized_blk = round(dct_transform_blk / quantize_step) * quantize_step;
        dct_quantized(range_vertical, range_horizontal) = dct_quantized_blk;

        % inverse DCT of quantized coefficients
        idct_transform_blk = idct2(dct_quantized_blk);
        idct_transform(range_vertical, range_horizontal) = idct_transform_blk;
        
        % reconstruction by motion compensation
        reconstructed_blk = idct_transform_blk + frame_0(ref_ii : ref_ii + blk_size - 1, ...
            ref_jj : ref_jj + blk_size - 1);
        reconstructed(range_vertical, range_horizontal) = reconstructed_blk;
    end
end

%% visualize and analyze
reconstructed(reconstructed < 0) = 0;
reconstructed(reconstructed > 255) = 255;
reconstructed = round(reconstructed);
figure; imshow(frame_1 / 255, 'border', 'tight');
figure; imshow(reconstructed / 255, 'border', 'tight');
mse = norm(frame_1 - reconstructed, 'fro') ^ 2 / H / W;
psnr = 10 * log10(255 * 255 / mse);
display(psnr)