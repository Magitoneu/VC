function [ If ] = motionBlur(Io,alpha)

    kernel = ones(1,10);
    kernel = kernel/10; 
    kernel = imrotate(kernel,alpha);
    If = imfilter(Io,kernel);

end

