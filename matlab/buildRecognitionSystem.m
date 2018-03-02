function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    train_features = [];
    for i=1:size(train_imagenames, 1)
        disp(i);
        trainMat = strcat('../data/',strrep(train_imagenames{i}, ".jpg", ".mat"));
        disp(trainMat);
        wordMap = load(trainMat);
        wordMap = wordMap.wordMap;
        train_features = [train_features, getImageFeaturesSPM(3, wordMap, size(dictionary, 1))];
    end

	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');
    
end