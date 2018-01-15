function [ p1, p2 ] = kClustering( points )
[~, C] = kmeans(points, 2, 'Distance', 'cityblock');
p1 = C(1,1:2);
p2 = C(2,1:2);
end
