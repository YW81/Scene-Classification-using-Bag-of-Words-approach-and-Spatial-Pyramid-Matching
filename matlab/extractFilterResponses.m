function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

    %if the image is grayscale, duplicate it into 3 channels
    if ndims(img) <= 2 
        img = repmat(img, [1 1 3]);
    end

    %determine if img is floating point matrix, if not, convert it to double
    img = im2double(img);

    %Applying RGB2Lab helper function to convert RGB to L*a*b* space
    lab_img = RGB2Lab(img);

    filterResponses = [];

    for i=1:size(filterBank, 1)
       filterResponses = cat(3, filterResponses, imfilter(lab_img, filterBank{i}, 'same', 'conv'));
    end

end