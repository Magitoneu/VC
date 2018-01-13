function [ points ] = removeFails( p )

[x, y] = size(p);

for i = 1:x
    if(p(i,5) == 0)
        for j = i:x
            if(abs(p(i,1) - p(j,1)) > 30  && abs(p(i,2) - p(j,2)) < 20)
                p(i,5) = 1;
                p(j,5) = 1;
            end
        end
    end
end
points = p(p(:,5) == 1, 1:4);

end


