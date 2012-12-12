GaussianFilter.m : to smooth
local_frame_difference.m  : three methods for local frame differences, optimizations of global frame differences not done here like the eliminiation of the second scoring function.
color_histogram.m : one of the methods for finding frame differences using color distribution
makelinear.m : converts a 2D array into 1D
compute_distance_hist.m : histogram based distance computation
read_all_frames.m : reads all the frames of a video.
compute_distance_spatiogram.m : spatiogram based distance computation
read_key_frames.m :reads only key frames, this functionality is not yet implemented.
createColorHistograms.m : creates a histogram based on colors
runner.m : main class for execution                                                    
edge_oriented_histogram.m : another measure for difference of two frames
spatiogram.m : spatiogram based measure for difference of two frames
getfilename.m : pads right number of zeros to the filename, utility func.
video_aggregate_scorer.m : ranking function (later on might use a classifier to learn the weights
global_frame_differences.m : global ranking function , opposite of local-frame-difference but takes too much time.
video_score.m : (TODO change the name) Main ranking function.

matlab-version: matlab 7.11.0 (R2010b)