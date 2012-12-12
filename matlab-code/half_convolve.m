
function [ conv_image ] = half_convolve( image,pos,image_filter )
%CONVOLVEX Summary of this function goes here
%   Detailed explanation goes here

%     void convolveX(std::vector<std::vector<T> >& image,
% 		   const std::vector<std::vector<unsigned char> >& mask,
% 		   const std::vector<float>& filter,
% 		   std::vector<std::vector<T> >& buffer) {
%     const int width = image[0].size();
%     const int height = image.size();
%     const int margin = ((int)filter.size()) / 2;
%     
%     for (int y = 0; y < height; ++y) {
%       for (int x = 0; x < width; ++x) {
% 	buffer[y][x] *= 0.0;
% 	
% 	if (!mask.empty() && mask[y][x] == 0)
% 	  continue;
% 	
% 	for (int j = 0; j < (int)filter.size(); ++j) {
% 	  int xtmp = x + j - margin;
% 	  if (xtmp < 0)
% 	    xtmp = 0;
% 	  else if (width <= xtmp)
% 	    xtmp = width - 1;
% 		   
% 	  const int ytmp = y;
% 
% 	  if (!mask.empty() && mask[ytmp][xtmp] == 0)
% 	    continue;
% 	  
% 	  buffer[y][x] += filter[j] * image[ytmp][xtmp];
% 	}
%       }
%     }
%     
%     buffer.swap(image);
%   }
%   
%   
    filt_size = length(image_filter);
    %margin = floor(filt_size() / 2);
    % we have to add +1 here because our image is starting from 1 not from
    % 0
    
    margin = floor(filt_size() / 2)+1;
    
    im_size=size(image,2);
    
      
   
        conv_image =0;
            
            for j=1:filt_size
                
                xtemp = pos + j - margin;
                
                if(xtemp >= 1 && xtemp <= im_size)
                        conv_image = conv_image + image_filter(j)*image(xtemp);
                end
                                
            end
        
    


end


