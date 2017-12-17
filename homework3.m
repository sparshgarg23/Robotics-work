target_image = imread('uttower_left.jpg');
image = imread('uttower_right.jpg');

[result_img, H, num_inliers, residual] = ...
    stitch_pair(image, target_image, 5, 5, 0.03, 1, 200, 4000);