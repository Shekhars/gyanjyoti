function [ mov ] = read_all_frames( movie_name,expected_fps )
%READ_ALL_FRAMES Summary of this function goes here
%   Detailed explanation goes here

xyloObj = VideoReader(movie_name);
fps = xyloObj.FrameRate;
%xyloObj = VideoReader('xylophone.mpg');
nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

index =1;

specified_frame_rate = expected_fps;

  specified_frame_rate = floor(fps/specified_frame_rate);
  
  modified_nFrames = ceil(nFrames / specified_frame_rate);
  
% Preallocate movie structure.
mov(1:modified_nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);


for k = 1:specified_frame_rate:nFrames
    mov(index).cdata = read(xyloObj, k);
    index = index+1;
    %imwrite(mov(k).cdata,getfilename('frames/',k,'.jpg'),'jpg');
end    
    
end

