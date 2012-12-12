
function s = compute_distance_spatiogram(h1,mu1,sigma1,  h2,mu2,sigma2)

C = 2*sqrt(2*pi);
C2 = 1/(2*pi);

q = sigma1+sigma2;
q = C * (q(1,1,:) .* q(2,2,:)) .^ (1/4);
sigmai = 1./(1./(sigma1+(sigma1==0)) + 1./(sigma2+(sigma2==0)));
Q = C * (sigmai(1,1,:) .* sigmai(2,2,:)) .^ (1/4);
q = permute(q, [1 3 2]);
Q = permute(Q, [1 3 2]);

x = mu1(1,:) - mu2(1,:);
y = mu1(2,:) - mu2(2,:);

sigmax = 2 * (sigma1+sigma2);
isigma = 1./(sigmax+(sigmax==0));
detsigmax = permute(sigmax(1,1,:) .* sigmax(2,2,:), [1 3 2]);
isigmaxx = permute(isigma(1,1,:), [1 3 2]);
isigmayy = permute(isigma(2,2,:), [1 3 2]);

z = C2 ./ sqrt(detsigmax) .* exp(-0.5 * (isigmaxx.*x.^2 + isigmayy.*y.^2));

dist = q .* Q .* z;

s = sum(sum(sqrt(h1).*sqrt(h2) .* dist));

