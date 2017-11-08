function [ If ] = recoverBlur(Io,alpha)

    kernel = ones(1,15);
    kernel = kernel/20; 
    kernel = imrotate(kernel,-alpha);
    If = imfilter(Io,kernel);

end
