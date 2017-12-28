function [reducedColorImage, reducedEnergyImage] = reduce_height(im, energyImage)
    [reducedColorImage, reducedEnergyImage] = reduce_width(permute(im, [2,1,3]), permute(energyImage, [2,1,3]));
    reducedColorImage = permute(reducedColorImage, [2,1,3]);
    reducedEnergyImage = permute(reducedEnergyImage, [2,1,3]);
    imshow(reducedColorImage);
end
