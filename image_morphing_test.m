% Test Script Written by Chien-Yi Wang 
% @ USC MCLab Summer Course 06/15/15

% Clear up
clc;
close all;

% Parameters of morphing rate and target image size
morph_rate = 1/30;
img_w = 300;
img_h = 450;


% Use Video Writer function and take each morphed images as the frame 
%% TODO %%
writerObj = VideoWriter('project.avi');
writerObj.FrameRate = 12;
open(writerObj);

for i = 1:7
    % Parse the images and resize to the same target size
    im1 = imread(['im' int2str(i) '.jpg']);
    im2 = imread(['im' int2str(i + 1) '.jpg']);
    im1_new = imresize(im1,[img_h img_w]);
    im2_new = imresize(im2,[img_h img_w]);
    % figure; imshow(im1_new);
    % figure; imshow(im2_new);

    % Click correspondence points (Use click_correspondences.m function)
    [im1_pts, im2_pts] = click_correspondences(im1_new, im2_new);
    im_pts = ( im1_pts + im2_pts ) / 2;

    % Image morphing and iterative recording
    tri = delaunay(im_pts);
    % Print out the triangular of two images 
    triplot(tri,im_pts(:,1),im_pts(:,2));


    %% Hint: Use for loop to get morphed images %%
    for frac = 0:morph_rate:1
        dissolve_frac = frac;
        warp_frac = frac;
        morphed_im = morph(im1_new, im2_new, im1_pts, im2_pts, tri, warp_frac, dissolve_frac);
    %     figure; imshow(morphed_im);
        writeVideo(writerObj, morphed_im);
    end
end
close(writerObj);