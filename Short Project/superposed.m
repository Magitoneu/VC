function [ superpos ] = superposed( x, y, Q )

xw = Q(4);
yw = Q(3);
superpos = x < Q(2) + xw && x + xw > Q(2) && y < Q(1) + yw && y + yw > Q(2);

end

