function [ str ] = getfilename( prefix,i,ext )
%GETFILENAME Summary of this function goes here
%   Detailed explanation goes here

      if (i< 10)
          str = '0000000';
          str = strcat(prefix,str, num2str(i),ext);
      elseif (i < 100)
          str = '000000';
          str = strcat(prefix,str, num2str(i),ext);
      elseif (i<1000)
          str = '00000';
          str = strcat(prefix,str, num2str(i),ext);
      elseif (i<10000)
          str = '0000';
          str = strcat(prefix,str, num2str(i),ext);
      elseif (i<100000)
          str = '000';
          str = strcat(prefix,str, num2str(i),ext);
      elseif (i<1000000)
          str = '00';
          str = strcat(prefix,str, num2str(i),ext);
      elseif (i<10000000)
          str = '0';
          str = strcat(prefix,str, num2str(i),ext);  
      else
          str = strcat(prefix,num2str(i),ext);
      end
end

