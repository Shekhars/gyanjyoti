function filt = GaussianFilter(fsize, sigma)

N = fsize; N2 = round((N+1)/2);
filt = zeros(N,N);
for j = 1:N
    for i = 1:N
        u = i-N2;
        v = j-N2;
        filt(j,i) = exp(-(u^2+v^2)/(2*sigma^2));
    end
end
filt = filt/(sum(sum(filt)));

