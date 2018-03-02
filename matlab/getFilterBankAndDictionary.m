function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();
    
    alpha = 70;
    K = 150;
    responseK = [];
    filterResponse2D = [];
    
    for i=1:length(imPaths)
        img = imread(imPaths{i});
        imgSize = size(img,1)* size(img,2);
        filterResponses = extractFilterResponses(img, filterBank);
        filterResponse2D = reshape(filterResponses, imgSize, 60);
        randPixel = randperm(imgSize,alpha); %select alpha random pixels
        disp(i);
        responseK = [responseK; filterResponse2D(randPixel,:)];
    end  
    [~,dictionary] = kmeans(responseK, K, 'EmptyAction','drop');
end
