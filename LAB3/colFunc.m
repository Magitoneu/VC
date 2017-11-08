function [ y ] = colFunc(x,k)
   [f, c] = size(x);
   y = x(round(f/2),:);
   for i=1:c
      if((y(1,i) == 255) ||(y(1,i) == 0))
          y(1,i) = median(x(:,i))+k;
      end
   end
   k
end

