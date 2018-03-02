
%To plot word Map as image
wordMap = load('../data/ocean/sun_adxkobqvuvqqogjv.mat');
imagesc(wordMap.wordMap);

%To create a montage of filters
img = imread('../data/ice_skating/sun_advbapyfkehgemjf.jpg');
filterResponses = extractFilterResponses(img, filterBank);
imagesWithFilters = reshape(filterResponses, size(img, 1), size(img, 2), 3, 20);
montage(imagesWithFilters, 'Size', [4, 5]);

%figure;
%h = getImageFeatures(wordMap, size(dictionary, 1));
%figure;
%h = getImageFeaturesSPM(3, wordMap, size(dictionary, 1))