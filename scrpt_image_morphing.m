% Test Script Written by Chien-Yi Wang 
% @ USC MCLab Summer Course 06/15/15

% Clear up
clc;
close all;

% Parameters of morphing rate and target image size
morph_rate = 1/60;
img_w = 400;
img_h = 600;

% Parse the images and resize to the same target size
%% TODO %%

% Click correspondence points (Use click_correspondences.m function)
%% TODO %%

% Image morphing and iterative recording
tri = delaunay(im_pts);
% Print out the triangular of two images 
triplot(tri,im_pts(:,1),im_pts(:,2));

% Use Video Writer function and take each morphed images as the frame 
%% TODO %%

%% Hint: Use for loop to get morphed images %%
% morphed_im = morph(im1_new, im2_new, im1_pts, im2_pts, tri, warp_frac, dissolve_frac);
    

