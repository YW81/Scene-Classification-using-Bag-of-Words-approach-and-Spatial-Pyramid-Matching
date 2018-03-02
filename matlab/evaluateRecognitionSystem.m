function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix
    
	load('vision.mat');
	load('../data/traintest.mat');

    C = zeros(8, 8); %confusion matrix
    for i=1:size(test_imagenames, 1)
        disp(i);
        guessedImage = guessImage(strcat('../data/', test_imagenames{i}));
        guessedImgID = find(strcmp(mapping, guessedImage));
        actualImgID = test_labels(i);
        C(guessedImgID, actualImgID) = C(guessedImgID, actualImgID) +1;
    end
    disp(C);
    accuracy = 100*trace(C)/sum(C(:));
    fprintf('Accuracy: %.2f\n', accuracy);
end