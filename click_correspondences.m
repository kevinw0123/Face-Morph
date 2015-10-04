function [im1_pts, im2_pts] = click_correspondences(im1, im2)
% CLICK_CORRESPONDENCES let the user to click the corresponding points in
% two images which are used to morph.
% Extract the size information of the image
[nr, nc, ~] = size(im1);

% Select corresponding points on two images
disp('Please do not click the four corner points, this function will choose them automatically.');
% Use the function cpselect to store points into the list [im1_pts im2_pts] 
[im2_pts, im1_pts] = cpselect(im2, im1,'Wait', true);

% Add the corner points into the list
im1_pts = [im1_pts; 0, 0; 0, nr; nc, nr; nc, 0];
im2_pts = [im2_pts; 0, 0; 0, nr; nc, nr; nc, 0];

% Show the points on two images
figure();
subplot(1,2,1);imshow(im1);title('Original Image');  axis image;
hold on; plot(im1_pts(:,1), im1_pts(:,2), 'r*');

subplot(1,2,2);imshow(im2);title('Objective Image'); axis image;
hold on; plot(im2_pts(:,1), im2_pts(:,2), 'g*')

end