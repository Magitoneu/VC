function [ correct, eye ] = inside( p, L, R)
eye = 'NULL';
if((p(1) > L(1)) && (p(1) < (L(1) + L(3))) && ((p(2) > L(2)) && (p(2) < (L(2) + L(4)))))
    correct = true;
    eye = 'L';
else
    correct = false;
end 
if((p(1) > R(1)) && (p(1) < (R(1) + R(3))) && ((p(2) > R(2)) && (p(2) < (R(2) + R(4)))))
    correct = true;
    eye = 'R';
end

end

