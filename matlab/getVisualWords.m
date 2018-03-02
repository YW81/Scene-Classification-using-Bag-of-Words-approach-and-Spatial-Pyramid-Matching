function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    wordMap = zeros(size(img,1), size(img,2));
    imgSize = size(img,1)*size(img,2);
    %Get filter responses for the image
    filterResponses = extractFilterResponses(img, filterBank);
    
    %Reshape the MXNX3K filter response to (M*N)X3K
    filterResponse2D = reshape(filterResponses, imgSize, 60);
    
    %Find the Euclidean distance between the filter response and the
    %responses in dictionary
    euclidDistance = pdist2(filterResponse2D, dictionary);
    
    %Get the minimum distance
    [minDist, minIndex] = min(euclidDistance, [], 2);
    
    %create wordMap of size MXN
    wordMap = reshape(minIndex, size(img,1), size(img,2));
end