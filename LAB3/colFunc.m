function [ y ] = colFunc(x)
   [f, c] = size(x);
   y = x(round(f/2),:);
   for i=1:c
      if((y(1,i) == 255) ||(y(1,i) == 0))
          y(1,i) = median(x(:,i));
      end
   end
end

%  [f, c] = size(x);
%     y = sum(x)/f;