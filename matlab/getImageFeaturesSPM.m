function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    %weights for each layer
    w1 = 0.25; w2 = 0.25; w3 = 0.5;
    
    %Layer 3: 4X4 matrix
    %pad the matrix with zeros to make it divisible by 4
    paddedWordMap = wordMap;
    M4rem = mod(size(wordMap, 1), 4);
    
    if M4rem ~= 0
        paddedWordMap = padarray(wordMap, [4-M4rem, 0],'post');
    end
    
    N4rem = mod(size(wordMap, 2), 4);
    if N4rem ~= 0
        paddedWordMap = padarray(paddedWordMap, [0, 4-N4rem],'post');
    end
   
    M4 = size(paddedWordMap, 1)/4; 
    N4 = size(paddedWordMap, 2)/4;
    cell = mat2cell(paddedWordMap, [M4 M4 M4 M4], [N4 N4 N4 N4]);
    
    %Create histograms for each cell and multiply it with weight and
    %concatenate all the histograms
    cathist3 = [];
    hist3 = {};
    for i = 1 : 4
        for j=1 : 4
            [hist3{i,j}, edges] = histcounts(cell{i, j}, (dictionarySize));
            hist3{i,j} = hist3{i,j} / sum(hist3{i,j});
            cathist3  = [cathist3, w3*hist3{i, j}];
        end
    end
    
    %Layer 2: 2X2 matrix
    hist2 = {};
    cathist2 = [];
    i = 1; j = 1;
    %From layer 3, create layer 2 histograms and then concatenate all 4
    %weighted histograms
    for p=1:2
        for q=1:2
            hist2{p,q} = hist3{i,j}+hist3{i,j+1}+hist3{i+1,j}+hist3{i+1,j+1};
            cathist2 = [cathist2, w2*hist2{p, q}];
            j = j+2;
        end
        j = 1;
        i = i + 2;
    end
    
    %Layer 1 :
    %From layer 2 histograms, create histogram for layer 1
    cathist1 = w1*(hist2{1, 1}+hist2{1, 2} + hist2{2, 1} + hist2{2, 2});

    h = [cathist1, cathist2, cathist3]; %concatenate all
    
    h = h / sum(h); %L1-Normalized
    h = h';
    assert(uint64(sum(h)) == 1); %to check if it is normalized
end