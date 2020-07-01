% Part of Final year project 2020 for Habib University 
% Author Wahaj Ahmad wa02234
%% For one image
close all
clear all
clc
%Reading the image
img = imread('93cm.jpg');
figure, imshow(img), title('Original Image');
%Makes the image upright
img = imrotate(img, -90);
figure, imshow(img), title('Upright Image');
% converts rgb image to grayscale
diff_im = rgb2gray(img);
figure, imshow(diff_im), title('Grayscale Image');
%extracting the Red color from grayscale image
diff_im = imsubtract(img(:,:,1), diff_im);
figure, imshow(diff_im), title('Only Red');
%Filtering the noise
diff_im = medfilt2(diff_im, [3 3]);
%Removes pixels of less intensity
diff_im = imsubtract(diff_im, 35);
%Converting grayscale image into binary image
diff_im = im2bw(diff_im,0.1);
figure, imshow(diff_im), title('Binary Image');
%disk filter of radius 15 pixels
se = strel('disk',15);
%remove all pixels less than 300 pixel
diff_im = bwareaopen(diff_im,300);
figure, imshow(diff_im);
%Closes small patches and smoothens the overall blob
diff_im = imclose(diff_im,se);  
figure, imshow(diff_im);
stats = regionprops(diff_im, 'BoundingBox','Centroid','Area');
drawnow;
subplot 122, imshow(diff_im), title('Output image'); 

hold on;
if ~isempty(stats)
    pxlHeightKnob = stats(1).BoundingBox(4);
    centroid1 = stats(1).Centroid;
    bb = stats(1).BoundingBox;
    bc = stats(1).Centroid;
    rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
    plot(bc(1),bc(2), '-m+')
end
hold off;
    
subplot 121, imshow(img), title('Original Image');