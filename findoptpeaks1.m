function [clustercenter,data2cluster,cluster2dataCell] = findoptpeaks1(dataPts,bandWidth);
if nargin < 3
    plotFlag = true;
    plotFlag = false;
end

[num_Dim,num_Pts] = size(dataPts);
num_Clust        = 0;
bandSq          = bandWidth^2;
initPointInds      = 1:num_Pts;
maxPosition          = max(dataPts,[],2);                          %biggest size in each dimension
minPosition          = min(dataPts,[],2);                          %smallest size in each dimension
boundBox        = maxPosition-minPosition;                        %bounding box size
sizeSpace       = norm(boundBox);                      
thresh      = 1e-3*bandWidth;                       %when mean has converged
clustercenter       = [];                                   %center of clust
visitedFlag = zeros(1,num_Pts,'uint8');             
numinitPts      = num_Pts;                              

peaks    = zeros(1,num_Pts,'uint16');             


while numinitPts

    temp_Ind         = ceil( (numinitPts-1e-6)*rand);        
    start_Ind           = initPointInds(temp_Ind);                  
    mean1          = dataPts(:,start_Ind);                          
    members       = [];                                                         
    this_Votes    = zeros(1,num_Pts,'uint16');         %used to resolve conflicts on cluster membership

    while 1     %loop untill convergence
        
        dist = sum((repmat(mean1,1,num_Pts) - dataPts).^2);    
        in_idx      = find(dist < bandSq);               
        this_Votes(in_idx) = this_Votes(in_idx)+1;  
        
        
        Old_Mean   = mean1;                                   
        mean1      = mean(dataPts(:,in_idx),2);                
        members   = [members in_idx];                      
        visitedFlag(members) = 1;                        
        
        %*** plot stuff ****
        if plotFlag
            figure(12345),clf,hold on
            if num_Dim == 2
                plot(dataPts(1,:),dataPts(2,:),'.')
                plot(dataPts(1,members),dataPts(2,members),'ys')
                plot(mean1(1),mean1(2),'go')
                plot(Old_Mean(1),Old_Mean(2),'rd')
                pause
            end
        end

        %stop 
        if norm(mean1-Old_Mean) < thresh
            
            %check for merge posibilities
            mergeWith = 0;
            for i = 1:num_Clust
                distToOther = norm(mean1-clustercenter(:,i));     
                if distToOther < bandWidth/2                    %if its within bandwidth/2 merge new and old
                    mergeWith = i;
                    break;
                end
            end
            
            
            if mergeWith > 0    
                clustercenter(:,mergeWith)       = 0.5*(mean1+clustercenter(:,mergeWith));            
                
                peaks(mergeWith,:)    = peaks(mergeWith,:) + this_Votes;    
            else    %its a new cluster
                num_Clust                    = num_Clust+1;                  
                clustercenter(:,num_Clust)       = mean1;                     
                                 
                peaks(num_Clust,:)    = this_Votes;
            end

            break;
        end

    end
    
    
    initPointInds      = find(visitedFlag == 0);           
    numinitPts      = length(initPointInds);                   

end

[val,data2cluster] = max(peaks,[],1);               


if nargout > 2
    cluster2dataCell = cell(num_Clust,1);
    for i = 1:num_Clust
        members = find(data2cluster == i);
        cluster2dataCell{i} = members;
    end
end


