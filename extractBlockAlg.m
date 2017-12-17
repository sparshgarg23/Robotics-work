function [features, valid_indices] = extractBlockAlg(I, points, blockSize)
% Define casting constants
intClass = 'int32';
uintClass = 'uint32';

% Define length of feature vector
lengthFV = cast(blockSize*blockSize, uintClass);

nPoints = size(points,1);
if (islogical(I))
    features = false(nPoints, lengthFV);
else
    features = zeros(nPoints, lengthFV, 'like', I);
end
valid_indices = zeros(nPoints, 1);

%--------------------------------------------------------
% Define working variables needed for feature extraction
%--------------------------------------------------------
% Determine image size
nRows = cast(size(I, 1), intClass);
nCols = cast(size(I, 2), intClass);

% Compute half length of blockSize-by-blockSize neighborhood in units of
% integer pixels
halfSize = cast( (blockSize-mod(blockSize, 2)) / 2, intClass);

%------------------
% Extract features
%------------------
nValidPoints = cast(0, uintClass);
% Iterate over the set of input interest points, extracting features when
% the blockSize-by-blockSize neighborhood centered at the interest point is
% fully contained within the image boundary.
for k = 1:nPoints
    % Convert current interest point coordinates to integer pixels (Note:
    % geometric origin is at (0.5, 0.5)).
    [c, r] = castAndRound(points, k, intClass);
    % c = cast_ef(round_ef(points(k,1)), intClass);
    % r = cast_ef(round_ef(points(k,2)), intClass);
    
    % Check if interest point is within the image boundary
    if (c > halfSize && c <= (nCols - halfSize) && ...
        r > halfSize && r <= (nRows - halfSize))
        % Increment valid interest point count
        nValidPoints = nValidPoints + 1;        
        % Reshape raw image data around the interest point into a feature
        % vector
        features(nValidPoints, :) = reshape(I(r-halfSize:r+halfSize, ...
            c-halfSize:c+halfSize), 1, lengthFV);
        % Save associated interest point location
        valid_indices(nValidPoints) = k;
    end
end

% Trim output data
features = features(1:nValidPoints, :);
valid_indices = valid_indices(1:nValidPoints,:);
valid_indices = extractValidPoints(points, valid_indices);
end