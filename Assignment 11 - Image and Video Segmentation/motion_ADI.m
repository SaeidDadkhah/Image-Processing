clear all
close all


A = zeros(256,256); % initialize a 256*256 image  

% initialize absolute ADI, positive ADI and Negative ADI
% all initialized to zero
% Note that all ADIs are of the same size with the image
% DO NOT change the name of the ADIs as they will be used later
ADI_abs = zeros(256,256);
ADI_pos = zeros(256,256);
ADI_neg = zeros(256,256);

% initialize the starting position of the moving object
% the moving object is a rectangle similar to the example in the lecture
% slides
start1 = 100;
start2 = 150;
start3 = 40;
start4 = 110;

%threshold T as in euations in the lecture slides regarding ADI
T = 0

%initialize the reference frame R
A(start1:start2, start3:start4) = 1;

%visualize the object and in the reference frame R
figure,imshow(A,[], 'border','tight');

j = 0;
for i = 5: 5 :50
        j = j + 12;
        A2 = zeros(256,256);
        A2(start1 + i: start2 + i, start3 + j: start4 + j) = 1;
        
        % You need to code up the follwing part that calculate the ADIs
        % Namely, the absolute ADI, the positive ADI and the negative ADI
        % Equations can be found in lecture slides regarding ADIs
        % You need to decide on the appropriate threshold T for this case
        % at line 23
        ADI_abs = ADI_abs + (abs(A - A2) > T);
        ADI_pos = ADI_pos + (A - A2 > T);
        ADI_neg = ADI_pos + (A - A2 < -T);
end

% The following part will calculate the moving speed 
% and the total space(in pixel number) occupied by the moving object
[row, col] = find(ADI_neg > 0);
speed_X_Direction = (max(col) - start4) / 10
speed_Y_Direction = (max(row) - start2) / 10
total_space_occupied = sum(sum(ADI_abs > 0))

% The following part helps you to visualize the ADIs you compute
% compare them with the example shown in lecture
% You should be getting someting very similar
figure,imshow(ADI_abs,[], 'border','tight');
figure,imshow(ADI_pos,[], 'border','tight');
figure,imshow(ADI_neg,[], 'border','tight');