
function s = compute_distance_hist(h1,h2)

s = sum(sum(sum(sqrt(h1).*sqrt(h2))));

