
%GLOBAL_FRAME_DIFFERENCES Summary of this function goes here
%   Detailed explanation goes here
% ---- Code to compare image histograms ----
function [color_score__,edge_score__,spatio_score__,score__] = global_frame_differences(movie_name, fps)

%gf = GaussianFilter(11,1.5);
mov = read_all_frames(movie_name,fps);
%mov = read_all_frames('38_Meter_High_Dive_ Goes_Wrong.avi');

 bins = 8;
mov= read_key_frames(mov);

init_frame=1;



nFrames = size(mov,2); 
 color_hist_values = zeros(nFrames-init_frame,nFrames-init_frame);
 edge_hist_values = zeros(nFrames-init_frame,nFrames-init_frame);
 spatio_hist_values = zeros(nFrames-init_frame,nFrames-init_frame);
 
 %init_frame = init_frame+1;
 tic;
for k = init_frame : nFrames
    im1 = double(mov(k).cdata);
    h1_color = color_histogram(im1, bins);
    h1_edge = edge_oriented_histogram(im1);
    [h1_spatio,mu1,sigma1] = spatiogram(im1, bins);
    for inner=k+1:nFrames
        %tic;
    % read in database image
    
    % read in query image
    im2 = double(mov(inner).cdata);

    % Both images are RGB Colour images
    % Extract an 8x8x8 colour histogram from each image
   
        

    h2 = color_histogram(im2, bins);
    % compare their histograms using the Bhattacharyya coefficient
    sim = compute_distance_hist(h1_color,h2);
    
    color_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
    color_hist_values(inner-init_frame+1,k-init_frame+1) = sim;

    
    %h2 = edge_oriented_histogram(im2);

    % compare their histograms using the Bhattacharyya coefficient
    %sim = compute_distance_hist(h1_edge,h2);
    sim = 0;
   
 
    edge_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
    edge_hist_values(inner-init_frame+1,k-init_frame+1) = sim; 
    
   
    [h2,mu2,sigma2] = spatiogram(im2, bins);

    
    % compare their histograms using the Bhattacharyya coefficient
    sim = compute_distance_spatiogram(h1_spatio,mu1,sigma1,h2,mu2,sigma2);
    
    
    spatio_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
    spatio_hist_values(inner-init_frame+1,k-init_frame+1) = sim;
     %toc;
    end
    spatio_hist_values(k,k) = 1;
    %display k
    k;
end
    [color_score__,edge_score__,spatio_score__,score__] = video_score(color_hist_values,edge_hist_values, spatio_hist_values);
toc;


% for k = init_frame : nFrames
%     im1 = double(mov(k).cdata);
%     h1_color = color_histogram(im1, bins);
%     h1_edge = edge_oriented_histogram(im1);
%     [h1_spatio,mu1,sigma1] = spatiogram(im1, bins);
%     for inner=k+1:nFrames
%         %tic;
%     % read in database image
%     
%     % read in query image
%     im2 = double(mov(inner).cdata);
% 
%     % Both images are RGB Colour images
%     % Extract an 8x8x8 colour histogram from each image
%    
%         
% 
%     h2 = color_histogram(im2, bins);
%     % compare their histograms using the Bhattacharyya coefficient
%     sim = compute_distance_hist(h1_color,h2);
%     
%     color_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
%     color_hist_values(inner-init_frame+1,k-init_frame+1) = sim;
% 
%     
%     %h2 = edge_oriented_histogram(im2);
% 
%     % compare their histograms using the Bhattacharyya coefficient
%     %sim = compute_distance_hist(h1_edge,h2);
%     sim = 0;
%    
%  
%     edge_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
%     edge_hist_values(inner-init_frame+1,k-init_frame+1) = sim; 
%     
%    
%     [h2,mu2,sigma2] = spatiogram(im2, bins);
% 
%     
%     % compare their histograms using the Bhattacharyya coefficient
%     sim = compute_distance_spatiogram(h1_spatio,mu1,sigma1,h2,mu2,sigma2);
%     
%     
%     spatio_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
%     spatio_hist_values(inner-init_frame+1,k-init_frame+1) = sim;
%      %toc;
%     end
%     spatio_hist_values(k,k) = 1;
%     %display k
%     k;
% end
%     [color_score__,edge_score__,spatio_score__,score__] = video_score(color_hist_values,edge_hist_values, spatio_hist_values);



end

