function [ref_ii, ref_jj, blk_residual] = block_match(blk, frame)

% frame and block dimensions
[H, W] = size(frame);
blk_size = size(blk, 1);

ref_ii = 1;
ref_jj = 1;
err = (255 ^ 2) * (blk_size ^ 2);
blk_residual = 255 * ones(blk_size, blk_size);

% loop over all blocks fully contained within the reference frame
for ii = 1 : H - blk_size + 1
    for jj = 1 : W - blk_size + 1
        ref_blk = frame(ii : ii + blk_size - 1, jj : jj + blk_size - 1);
        err_blk = norm(ref_blk - blk, 'fro') ^ 2;
        % find the block with the smallest matching error
        if err_blk <= err
            err = err_blk;
            blk_residual = blk - ref_blk;
            ref_ii = ii;
            ref_jj = jj;
        end
    end
end