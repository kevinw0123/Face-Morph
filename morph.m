function morphed_im = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)
% MORPH provides the morphing result of the two input images, which
% represent one kind of intermediate state
% Written by Chien-Yi Wang
% @USC MCLab 06/15/15

% Check whether the number of control points in both images are the same
assert(size(im1_pts, 1) == size(im2_pts, 1),'Control points in two images should be the same amount!');

% Check whether the size of two images are the same
assert(size(im1,1) == size(im2,1),'Two images should be in the same size');

% Initialize parameters
nr         = size(im1, 1); %number of rows
nc         = size(im1, 2); %number of columns
tri_num    = size(tri,1);  %number of triangles
im1_warp   = im1; %warp image for image1
im2_warp   = im2; %warp image for image2
sub_array  = [repmat(1:nc, 1, nr); reshape(repmat(1:nr, nc, 1), [1 nr*nc]); ones(1, nr*nc)]; 
ps_1       = zeros(3, nr * nc); %temporary point for warped image 1
ps_2       = zeros(3, nr * nc); %temporary point for warped image 2
T1 = zeros(3,3,tri_num);
T2 = zeros(3,3,tri_num);
% Intermediate points
imwarp_pts = (1 - warp_frac) * im1_pts + warp_frac * im2_pts;

% Loop for each triangle to calculate the transform matrix
row_ind = mytsearch(imwarp_pts(:,1), imwarp_pts(:,2), tri, sub_array(1,:)', sub_array(2,:)');
%% TODO - The MAIN PART %%

for i = 1 : tri_num
    loc = tri(i,:);
    
    a1 = [im1_pts(loc(1),:),1]';
    b1 = [im1_pts(loc(2),:),1]';
    c1 = [im1_pts(loc(3),:),1]';
    A1 = [a1 b1 c1];
    
    a2 = [im2_pts(loc(1),:),1]';
    b2 = [im2_pts(loc(2),:),1]';
    c2 = [im2_pts(loc(3),:),1]';
    A2 = [a2 b2 c2];
    
    a = [imwarp_pts(loc(1),:),1]';
    b = [imwarp_pts(loc(2),:),1]';
    c = [imwarp_pts(loc(3),:),1]';
    B = [a b c];
    
    T1(:,:,i) = B/A1;
    T2(:,:,i) = B/A2;
end
% Loop for each pixel (ps_1 and ps_2) to do backward mapping
% (interpolation) to get the right color for im1_warp and im2_warp
%% TODO %%
for i = 1:size(row_ind,1)
    if isnan(row_ind(i))
        continue;
    end
    P1 = inv(T1(:,:,row_ind(i)))*sub_array(:,i);
    color = interpolate(im1, P1(2)/P1(3), P1(1)/P1(3));
    im1_warp(sub_array(2, i), sub_array(1, i), :) = color;
    
    P2 = inv(T2(:,:,row_ind(i)))*sub_array(:,i);
    color = interpolate(im2, P2(2)/P2(3), P2(1)/P2(3));
    im2_warp(sub_array(2, i), sub_array(1, i), :) = color;
end
% Dissolve two warpped images
%% TODO %%
morphed_im = (1-dissolve_frac) *im1_warp + dissolve_frac *im2_warp;
morphed_im = uint8(morphed_im);

%Show your image in the end to check the result
%% TODO %%
% figure(); imshow(morphed_im); axis image; title('Image Morphing');
end