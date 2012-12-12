function [ color_score, edge_score , spatio_score, comb_score ] = video_score( color_hist,edge_hist,spatio_hist )
%VIDEO_SCORE Summary of this function goes here
%   Detailed explanation goes here
 

   edge_hist(isnan(edge_hist))=0;
   
   %number of elements
   %todo(DONE) upper triangular matrix
   hist_size = numel(triu(color_hist,1));
   
   color_score = sum(makelinear(triu(color_hist,1)))/hist_size;
   edge_score = sum(makelinear(edge_hist))/hist_size;
   spatio_score = sum(makelinear(spatio_hist))/hist_size;
   
   comb_score = video_aggregate_scorer(color_score, edge_score , spatio_score);

end

