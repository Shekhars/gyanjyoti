
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
 %mu = zeros(1,,nFrames-init_frame+1);
 %sigma = zeros(1,nFrames-init_frame+1);
 
 for jj= init_frame: nFrames
     
         im1 = double(mov(jj).cdata);
         color_hist_array(jj,:) = color_histogram(im1, bins);
         [spatio_gram_array(jj,:),mu(jj,:,:),sigma(jj,:,:,:)] = spatiogram(im1, bins);
 end
 
 
 tic;
for k = init_frame : nFrames
    %im1 = double(mov(k).cdata);
    h1_color = squeeze(color_hist_array(k,:));%color_histogram(im1, bins);
    %h1_edge = edge_oriented_histogram(im1);
    %[h1_spatio,mu1,sigma1] = spatiogram(im1, bins);
    h1_spatio = squeeze(spatio_gram_array(k,:));
    mu1 = squeeze(mu(k,:,:));
    sigma1 = squeeze(sigma(k,:,:,:));
    
    for inner=k+1:nFrames
        %tic;
    % read in database image
    
    % read in query image
    %im2 = double(mov(inner).cdata);

    % Both images are RGB Colour images
    % Extract an 8x8x8 colour histogram from each image
   
        

    h2 = squeeze(color_hist_array(inner,:));%color_histogram(im2, bins);
    % compare their histograms using the Bhattacharyya coefficient
    sim = compute_distance_hist(h1_color,h2);
    
    color_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
    color_hist_values(inner-init_frame+1,k-init_frame+1) = sim;

    
    %h2 = edge_oriented_histogram(im2);

    % compare their histograms using the Bhattacharyya coefficient
    %sim = compute_distance_hist(h1_edge,h2);
    sim = 0;
   
 
    %edge_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
    %edge_hist_values(inner-init_frame+1,k-init_frame+1) = sim; 
    
   
    %[h2,mu2,sigma2] = spatiogram(im2, bins);
    h2 = squeeze(spatio_gram_array(inner,:));
    mu2 = squeeze(mu(inner,:,:));
    sigma2 = squeeze(sigma(inner,:,:,:));

    
    % compare their histograms using the Bhattacharyya coefficient
    sim = compute_distance_spatiogram(h1_spatio,mu1,sigma1,h2,mu2,sigma2);
    
    
    spatio_hist_values(k-init_frame+1,inner-init_frame+1) = sim;
    spatio_hist_values(inner-init_frame+1,k-init_frame+1) = sim;
     %toc;
    end
    k;
end
    [color_score__,edge_score__,spatio_score__,score__] = video_score(color_hist_values,edge_hist_values, spatio_hist_values);
toc;
   

end

