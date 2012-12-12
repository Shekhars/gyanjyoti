function [ gauss_I ] = gaussI( sigmad )


   marginD = ceil(2*sigmad);
   sizeD = 2*marginD+1;
   
   gauss_I = zeros(1,sizeD);
   
   denom = 0;
   
   for x=1:sizeD
       xtmp = x-1 - marginD;
       dtmp =  exp(- (xtmp * xtmp) / (2 * sigmad * sigmad));
       gauss_I(1,x) = dtmp;
       denom = denom + dtmp;
       
   end
   
   gauss_I = gauss_I/denom;

end

