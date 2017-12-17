[fileName,pathName] = uigetfile('*.png')
dname       = fullfile(pathName,fileName)
filelist = dir([fileparts(dname) filesep '*.png']);
fileNames = {filelist.name}';
num_frames = (numel(filelist));
I = imread((fileNames{1})); %to show the first image in the selected folder
sequence = zeros([size(I) num_frames],class(I));
sequence(:,:,1) = I;
for p = 2:num_frames
    sequence(:,:,p) = imread(fileNames{p});
end
[m,n,f]=size(sequence);
for k = 1:f
     % imshow(sequence(:,:,k));
     % title(sprintf('Original Image # %d',k));
      
end
rects = zeros(f-1,4);

frames_to_print = [1, 100, 200, 300, 400];
%Detecting features and constructing rectangle
Corners=findInterest(sequence(:,:,1),10,20);
X=Corners(:,2);
Y=Corners(:,1);

current_rect = [203, 315, 245, 367];
width = abs(current_rect(1)-current_rect(3));
height = abs(current_rect(2)-current_rect(4));

for i=1:f-1
    img = sequence(:,:,i);
    img_next = sequence(:,:,i+1);
    
    imshow(img);
    hold on;
    rectangle('Position',[current_rect(1),current_rect(2),width,height], 'LineWidth',3, 'EdgeColor', 'y');
    hold off;
    pause(0.1);
    
   
    [u,v] = LucasKanade(img,img_next,current_rect);
	if current_rect(1)+u >= 1 && current_rect(1)+u <= n && ...
        current_rect(2)+v >= 1 && current_rect(2)+v <= m && ...
        current_rect(3)+u >= 1 && current_rect(3)+u <= n && ...
        current_rect(4)+v >= 1 && current_rect(4)+v <= m
        current_rect = round([current_rect(1)+u current_rect(2)+v current_rect(3)+u current_rect(4)+v]);
        rects(i,:) = current_rect;
    end
end


    







