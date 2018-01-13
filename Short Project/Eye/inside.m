function [ correct, eye ] = inside( p, L, R)
eye = 'NULL';
if((p(2) > L(1)) && (p(2) < (L(1) + L(3))) && ((p(1) > L(2)) && (p(1) < (L(2) + L(4)))))
    correct = 1;
    eye = 'L';
else
    correct = 0;
end 
if((p(2) > R(1)) && (p(2) < (R(1) + R(3))) && ((p(1) > R(2)) && (p(1) < (R(2) + R(4)))))
    correct = 1;
    eye = 'R';
end

end

