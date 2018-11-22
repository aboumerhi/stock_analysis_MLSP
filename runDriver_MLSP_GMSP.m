%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% COURSE:              Machine Learning for Signal Processing
% AUTHORS:             Khaled Aboumerhi, Ashley Kiemen & Huixiang Li
% ASSIGNMENT:          Group Project
% TITLE:               General Motors Stock Prediction
% DUE DATE:            December XX, 2018
% LAST DATE: REVISED:  11/22/18
% REVISION ASSIGNMENT: rev B

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc;

%% IMPORT DATA

cd '../data/FinalData/over1000DataPts'

list = dir;

[listSize, ~] = size(list);
numFiles = listSize - 2;

fileNames = strings(numFiles, 1);
sizes = zeros(numFiles, 1);
masterData = cell(numFiles, 1);
masterDataScaled = cell(numFiles, 1);

%this is because the first two files in the list are prior directories
for i = 3:(numFiles + 2)
    
    fileNames(i - 2) = string(list(i).name);
    info = importdata(fileNames(i - 2));
    allData = info.data;
    
    sizes(i - 2) = size(allData, 1);
    masterData{i - 2} = allData;
    
end

%% RESIZE DATA BASED ON THE SMALLEST SET w/ & w/o DOW INFORMATION

minSize = min(sizes);

openDataDOW = zeros(minSize, numFiles);
highDataDOW = zeros(minSize, numFiles);
lowDataDOW = zeros(minSize, numFiles);
closeDataDOW = zeros(minSize, numFiles);
volumeDataDOW = zeros(minSize, numFiles);

openData = zeros(minSize, numFiles - 1);
highData = zeros(minSize, numFiles - 1);
lowData = zeros(minSize, numFiles - 1);
closeData = zeros(minSize, numFiles - 1);
volumeData = zeros(minSize, numFiles - 1);

masterSets = cell(5, 2);

for i = 1:numFiles
    
    A = masterData{i};
    A = A([1:minSize], :);
    
    masterDataScaled{i} = A;
    
    openDataDOW(:, i) = A(:, 1);
    highDataDOW(:, i) = A(:, 2);
    lowDataDOW(:, i) = A(:, 3);
    closeDataDOW(:, i) = A(:, 4);
    volumeDataDOW(:, i) = A(:, 5);
    
    masterSets{1, 1} = openDataDOW;
    masterSets{2, 1} = highDataDOW;
    masterSets{3, 1} = lowDataDOW;
    masterSets{4, 1} = closeDataDOW;
    masterSets{5, 1} = volumeDataDOW;
    
    if i ~= 1
        
        openData(:, i - 1) = A(:, 1);
        highData(:, i - 1) = A(:, 2);
        lowData(:, i - 1) = A(:, 3);
        closeData(:, i - 1) = A(:, 4);
        volumeData(:, i - 1) = A(:, 5);
        
        masterSets{1, 2} = openData;
        masterSets{2, 2} = highData;
        masterSets{3, 2} = lowData;
        masterSets{4, 2} = closeData;
        masterSets{5, 2} = volumeData;
                
    end
    
end

clear A i;
clear info allData sizes;

cd '../../../src'

%% PERFORM PCA ANALYSIS ON THE MODELS

corrMat = cell(5, 2);

for i = 1:size(corrMat, 1)
    
    X1 = masterSets{i, 1};
    X2 = masterSets{i, 2};
    
    corrMat{i, 1} = pca(X1);
    corrMat{i, 2} = pca(X2); 
    
end

clear X1 X2 i;








