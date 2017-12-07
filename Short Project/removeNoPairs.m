function [ points ] = removeNoPairs( p )

[x, y] = size(p);

for i = 1:x
    if(p(i,3) == 0)
        for j = i:x
            if(abs(p(i,1) - p(j,1)) < 30  && abs(p(i,2) - p(j,2)) > 30)
                p(i,3) = 1;
                p(j,3) = 1;
            end
        end
    end
end
points = p(p(:,3) == 1, 1:2);

end

