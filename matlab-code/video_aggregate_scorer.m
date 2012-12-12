function [ comb ] = video_aggregate_scorer (color_score, edge_score , spatio_score)
%VIDEO_SCORER Summary of this function goes here
%   Detailed explanation goes here
    comb = (color_score+ edge_score+ spatio_score)/3;
end

