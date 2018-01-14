function [ distance ] = getDistance( A, B )
%GETDISTANCE Get the euclidean distance between two points a and b.

    distance = hypot(A(1)-B(1), A(2) - B(2));

end

