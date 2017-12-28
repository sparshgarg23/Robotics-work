function verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap)
    M = cumulativeEnergyMap;
    [rowSize, colSize] = size(cumulativeEnergyMap);
    verticalSeam = zeros(rowSize, 1);
    [lowestEnergyValue, lowestEnergyColPos] = min(cumulativeEnergyMap(end,:));
    verticalSeam(end) = lowestEnergyColPos;
    for i = rowSize-1:-1:1
        if lowestEnergyColPos == 1 %if pixel is at left edge
            [value, colIndex] = min([M(i, lowestEnergyColPos), M(i, lowestEnergyColPos+1)]);
            if colIndex == 1
                verticalSeam(i) = lowestEnergyColPos;
            elseif colIndex == 2
                verticalSeam(i) = lowestEnergyColPos + 1;
            end
        elseif lowestEnergyColPos == colSize %if pixel is at right edge
            [value, colIndex] = min([M(i, lowestEnergyColPos-1), M(i, lowestEnergyColPos)]); 
            if colIndex == 1
                verticalSeam(i) = lowestEnergyColPos - 1;
            elseif colIndex == 2
                verticalSeam(i) = lowestEnergyColPos;
            end
        else 
            [value, colIndex] = min([M(i, lowestEnergyColPos-1), M(i, lowestEnergyColPos), M(i, lowestEnergyColPos+1)]);
            if colIndex == 1
                verticalSeam(i) = lowestEnergyColPos - 1;
            elseif colIndex == 2
                verticalSeam(i) = lowestEnergyColPos;
            elseif colIndex == 3
                verticalSeam(i) = lowestEnergyColPos + 1;
            end
            lowestEnergyColPos = verticalSeam(i);
        end
    end
end