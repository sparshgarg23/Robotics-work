function [gaussian_pyramid, laplacian_pyramid] = gausspyramid(img, levels, sigma, hsize)
if nargin < 4
    hsize = [5,5];
end
if nargin < 3
    sigma = 2;
end
widthsize = [size(img, 1)];
heightsize = [size(img, 2)];
for i = 2:levels
    widthsize(end+1) = floor(widthsize(end) / 2);
    heightsize(end+1) = floor(heightsize(end) / 2);
end
%Gaussian Filter
G = fspecial('gaussian',hsize, sigma);
gaussian_pyramid = {img};
laplacian_pyramid = {};
for idx = 1:(levels - 1)
    cimg = gaussian_pyramid{end};
    gimg = imfilter(cimg, G, 'same');
    gimg = imresize(gimg, [widthsize(idx+1), heightsize(idx+1)]);
    gaussian_pyramid{end+1} = gimg;
    
    % Calucate laplacians
    laplacian_img = cimg - imresize(gimg, [widthsize(idx), heightsize(idx)]);
    laplacian_pyramid{end + 1} = laplacian_img;
end
laplacian_pyramid{end+1} = gaussian_pyramid{end};
%SHow the results

ha = plotter(2,5,[.01 .03],[.1 .01],[.01 .01]);

for figidx = 1:levels
    gaussian_fig_idx = figidx;
    laplacian_fig_idx = figidx+levels;
    axes(ha(gaussian_fig_idx)); imshow(gaussian_pyramid{figidx} * 255);
    axes(ha(laplacian_fig_idx)); imagesc(laplacian_pyramid{figidx}); colormap gray;
end
end