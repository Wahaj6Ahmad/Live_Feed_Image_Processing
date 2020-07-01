% Part of Final year project 2020 for Habib University 
% Author Wahaj Ahmad wa02234
% Uses IP webcam Application available on Google Play Store for Android
% Camera Calibration required
%% Live Feed from mobile
url = 'http://192.168.18.15:8080/shot.jpg'; 
focalLength = 4.2;
realHeight = 25;
frameHeight = 1920;
sensorHeight = 4.5; 
pxlsize = 1.4e-6;
while (1)                  
    videoFrame = imread(url);
    videoFrame = imrotate(videoFrame, -90);
    diff_im = imsubtract(videoFrame(:,:,1), rgb2gray(videoFrame));
    diff_im = medfilt2(diff_im, [3 3]);
    diff_im = imsubtract(diff_im, 35);
    diff_im = im2bw(diff_im,0.1);
    se = strel('disk',15);
    diff_im = bwareaopen(diff_im,300);
    diff_im = imclose(diff_im,se);  
    stats = regionprops(diff_im, 'BoundingBox','Centroid','Area');
    drawnow;
    imshow(diff_im);
    
    hold on;
    if ~isempty(stats)
        pxlHeightKnob = stats(1).BoundingBox(4);
        disth1 = (focalLength*realHeight*frameHeight)/(pxlHeightKnob*sensorHeight);
        centroid = stats(1).Centroid;
        bb = stats(1).BoundingBox;
        bc = stats(1).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2), '-m+')
        plot(540,960,'-r*')
    end
    hold off;
    % K = camparams
rX1 = (centroid(1)-(1080/2))*500/2943.3;
rY1 = (centroid(2)-(1920/2))*500/2924.9;
% K = camparams - disth
rX11 = (centroid(1)-(1080/2))*disth1/2943.3;
rY11 = (centroid(2)-(1920/2))*disth1/2924.9;
% K = camparams 23mm
rX2 = (centroid(1)-(1080/2))*disth1/3132.3;
rY2 = (centroid(2)-(1920/2))*disth1/3138.7;
% K = camparams 65mm
rX3 = (centroid(1)-(1080/2))*disth1/3115;
rY3 = (centroid(2)-(1920/2))*disth1/3124.1;
    
end

