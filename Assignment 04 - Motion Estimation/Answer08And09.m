clear

% Read image
i1 = imread('Frame 1.jpg');
i2 = imread('Frame 2.jpg');

% Cast uint8 to double
I1 = double(i1);
I2 = double(i2);

bTargetX = 32;
bTargetY = 32;
bTarget = I2(65:(65 + bTargetX - 1), 81:(81 + bTargetX - 1));

% Block Mathing with MAE
x = 0;
y = 0;
mae = realmax();
for j = 1:321
    for i = 1:257
        cmae = sum(sum(abs(bTarget - I1(i:(i + bTargetX - 1), j:(j + bTargetY - 1))))) / ...
            (bTargetX * bTargetY);
        if cmae < mae
            display(cmae);
            mae = cmae;
            x = i;
            y = j;
        end
    end
end