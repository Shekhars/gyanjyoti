function [color_score__,edge_score__,spatio_score__,score__] = runner()
    %  RUNNER Summary of this function goes here
    %  This is the main class that executes the functionality.
    %  Detailed explanation goes here
   clear all;
   %   Manually set frames per second 
   %   TODO (clear all, clears everything
   fps = 2;
   
   %pos_train_file = 'C:/Documents and Settings/ntandon/My Documents/blind-project/blind data/avi files/positive';
 % [color_score__,edge_score__,spatio_score__,score__] = local_frame_difference('News Bulletin - 20_30GMT update.avi',fps)
  
   threshold = 0.62;
   false_pos=0; false_neg=0; true_pos=0; true_neg=0;
   
   
   
   
   %neg_train_file = 'C:/Documents and Settings/ntandon/My Documents/blind-project/blind data/avi files/negative';
   neg_train_file = 'C:/Documents and Settings/ntandon/My Documents/blind-project/blind data/avi files/corrected-negative';
   current_folder = cd(neg_train_file); 
   neg_files = dir('*.avi');
  
   
   % compute negative files
   
   for fileIter=1:size(neg_files,1)
       tic;
        movie_name = neg_files(fileIter).name;
        try
        %[color_score__,edge_score__,spatio_score__,score__] = local_frame_difference(movie_name,fps);
        %[color_score__,edge_score__,spatio_score__,score__] = faster_global_frame_differences(movie_name,fps);
        [color_score__,edge_score__,spatio_score__,score__] = lg_model(movie_name,fps,3);

        if(score__ < threshold)
           true_neg = true_neg + 1 ;
        end
        
        if(score__ >= threshold)
            false_pos = false_pos + 1 ;
        end
        fprintf('[ %d / %d ]\tFile : %s\tscore : %f\tcolor_score : %f\tspatio_score : %f\n', fileIter,size(neg_files,1),movie_name, score__,color_score__, spatio_score__);        
        
        catch ME1
         fprintf('[ %d / %d ]\tFile : %s\t EXCEPTION IN READING \n', fileIter,size(neg_files,1),movie_name);
        end
        toc;    
   end
  
         fprintf('INTERMEDIATE\ttrue pos =  %d \n false pos = %d \n true neg =  %d \n false neg = %d \n', true_pos,false_pos,true_neg, false_neg);        
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   % compute positive files
   
   pos_train_file = 'C:/Documents and Settings/ntandon/My Documents/blind-project/blind data/avi files/corrected-positive';
   current_folder = cd(pos_train_file);
   pos_files = dir('*.avi');
   
   for fileIter=1:size(pos_files,1)
       tic;
        movie_name = pos_files(fileIter,1).name;
               
        try
        %[color_score__,edge_score__,spatio_score__,score__] = local_frame_difference(movie_name,fps);
        %[color_score__,edge_score__,spatio_score__,score__] = faster_global_frame_differences(movie_name,fps);
        [color_score__,edge_score__,spatio_score__,score__] = lg_model(movie_name,fps,3);
        
        if(score__ >= threshold)
           true_pos = true_pos + 1 ;
        end        
        if(score__ < threshold)
            false_neg = false_neg + 1 ;
        end        
        fprintf('[ %d / %d ]\tFile : %s\tscore : %f\tcolor_score : %f\tspatio_score : %f\n', fileIter,size(pos_files,1),movie_name, score__,color_score__, spatio_score__);        
        catch ME1
         fprintf('[ %d / %d ]\tFile : %s\t EXCEPTION IN READING \n', fileIter,size(pos_files,1),movie_name);
        end
        toc;
   end   
  
   
        fprintf('true pos =  %d \n false pos = %d \n true neg =  %d \n false neg = %d \n', true_pos,false_pos,true_neg, false_neg);        
   
   
   
   
   
   
   
   
end

