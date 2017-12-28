function cumulativeEnergyMap = cumulative_minimum_energy_map(energyImage, seamDirection)
    [rowSize, colSize] = size(energyImage);
    M = zeros(rowSize, colSize);
    if strcmp(seamDirection, 'VERTICAL')
        j = 1
        M(1,:) = energyImage(1,:);
        for i = 2:rowSize
            for j = 1:colSize
                if j == 1  %if pixel is at left edge
                    M(i, j) = energyImage(i,j) + min([M(i-1, j), M(i-1, j+1)]); 
                elseif j == colSize  %if pixel is at right edge
                    M(i, j) = energyImage(i,j) + min([M(i-1, j-1), M(i-1, j)]); 
                else
                    M(i, j) = energyImage(i,j) + min([M(i-1, j-1), M(i-1, j), M(i-1, j+1)]);
                end
            end
        end
    elseif strcmp(seamDirection, 'HORIZONTAL')
        i = 1;
        M(:,1) = energyImage(:,1);
        for j = 2:colSize
            for i = 1:rowSize
                if i == 1
                    M(i, j) = energyImage(i,j) + min([M(i, j-1), M(i+1, j-1)]);
                elseif i == rowSize
                    M(i, j) = energyImage(i,j) + min([M(i-1, j-1), M(i, j-1)]);
                else
                    M(i, j) = energyImage(i,j) + min([M(i-1, j-1), M(i, j-1), M(i+1, j-1)]);
                end
            end
        end
    end
    cumulativeEnergyMap = M;
end