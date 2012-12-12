% ---- Code to compare image histograms ----
function [color_score__,edge_score__,spatio_score__,score__] = local_frame_difference(movie_name, fps)


mov = read_all_frames(movie_name,fps);
%mov = read_all_frames('38_Meter_High_Dive_ Goes_Wrong.avi');

 bins = 8;
mov= read_key_frames(mov);

init_frame=1;



nFrames = size(mov,2); 
 color_hist_values = zeros(1,nFrames-init_frame);
 edge_hist_values = zeros(1,nFrames-init_frame);
 spatio_hist_values = zeros(1,nFrames-init_frame);
 
 init_frame = init_frame+1;
 
for k = init_frame : nFrames
 
    % read in database image
    im1 = double(mov(k-1).cdata);
    % read in query image
    im2 = double(mov(k).cdata);

    % Both images are RGB Colour images
    % Extract an 8x8x8 colour histogram from each image
   
    
    h1 = color_histogram(im1, bins);
    h2 = color_histogram(im2, bins);

    % compare their histograms using the Bhattacharyya coefficient
    sim = compute_distance_hist(h1,h2);
 
    
    color_hist_values(k-init_frame+1) = sim;

    %h1 = edge_oriented_histogram(im1);
    %h2 = edge_oriented_histogram(im2);

    % compare their histograms using the Bhattacharyya coefficient
    %sim = compute_distance_hist(h1,h2);
    
%     if(isnan(sim))
%         sim = 0;
%     end;

% DO NOT USE edge score since its very expensive.
    sim =0;
    edge_hist_values(k-init_frame+1) = sim;
     
    
   
    [h1,mu1,sigma1] = spatiogram(im1, bins);
    [h2,mu2,sigma2] = spatiogram(im2, bins);

    % compare their histograms using the Bhattacharyya coefficient
    sim = compute_distance_spatiogram(h1,mu1,sigma1,h2,mu2,sigma2);
    spatio_hist_values(k-init_frame+1) = sim;

     
end
    [color_score__,edge_score__,spatio_score__,score__] = video_score(color_hist_values,edge_hist_values, spatio_hist_values);

    




% % read in database image
% im1 = double(imread('frames/00000001.jpg'));
% % read in query image
% im2 = double(imread('frames/00001010.jpg'));
% 
% % Both images are RGB Colour images
% % Extract an 8x8x8 colour histogram from each image
% bins = 8;
% h1 = color_histogram(im1, bins);
% h2 = color_histogram(im2, bins);
% 
% % compare their histograms using the Bhattacharyya coefficient
% sim = compute_distance_hist(h1,h2);
% 
% % 0 = very low similarity
% % 0.9 = good similarity
% % 1 = perfect similarity
% disp(sprintf('Image histogram similarity = %f', sim));
% 
% 
% 
% h1 = edge_oriented_histogram(im1);
% h2 = edge_oriented_histogram(im2);
% 
% % compare their histograms using the Bhattacharyya coefficient
% sim = compute_distance_hist(h1,h2);
% 
% % 0 = very low similarity
% % 0.9 = good similarity
% % 1 = perfect similarity
% disp(sprintf('Edge orinted histogram similarity = %f', sim));
% 
% 
% 
% 
% 
% % ---- Code to compare image SPATIOGRAMS ----
% 
% % Both images are RGB Colour images
% % Extract an 8x8x8 colour SPATIOGRAM from each image
% bins = 8;
% [h1,mu1,sigma1] = spatiogram(im1, bins);
% [h2,mu2,sigma2] = spatiogram(im2, bins);
% 
% % compare their histograms using the Bhattacharyya coefficient
% sim = compute_distance_spatiogram(h1,mu1,sigma1,h2,mu2,sigma2);
% 
% % 0 = very low similarity
% % 0.9 = good similarity
% % 1 = perfect similarity
% disp(sprintf('Image spatiogram similarity = %f', sim));


