%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% COURSE:              Machine Learning for Signal Processing 
% AUTHORS:             Ashley Kiemen, Khaled Aboumerhi, & Huixiang Li 
% ASSIGNMENT:          Group Project
% TITLE:               General Motors Stock Prediction
% DUE DATE:            November 14, 2018 
% LAST DATE: REVISED:  11/14/18
% REVISION ASSIGNMENT: rev A

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc;

%% INITIALIZE VARIABLES FOR IMPORTING DATA

cd '../data/FinalData/over1000DataPts'

list = dir;

listSize = size(list, 1);
listSize = listSize - 2;

fileNames = strings(listSize, 1);
sizes = zeros(listSize, 2);
openData = cell(listSize, 2);
highData = cell(listSize, 2);
lowData = cell(listSize, 2);
closeData = cell(listSize, 2);
volumeData = cell(listSize, 2);
timeData = cell(listSize, 2);
masterData = cell(listSize, 2);

openData_f = cell(listSize, 2);
highData_f = cell(listSize, 2);
lowData_f = cell(listSize, 2);
closeData_f = cell(listSize, 2);
volumeData_f = cell(listSize, 2);
timeData_f = cell(listSize, 2);
masterData_f = cell(listSize, 2);

%% IMPORT DATA

for i = 3:size(list)
        
    fileNames(i - 2) = string(list(i).name);
    info = importdata(fileNames(i - 2));
    timeVec = info.textdata;
    allData = info.data;
    
    sizes(i - 2) = size(allData, 1);
    
    opens = allData(:, 1);
    highs = allData(:, 2);
    lows = allData(:, 3);
    closes = allData(:, 4);
    volume = allData(:, 5);
    
    T = timeVec([2:size(timeVec, 1)], 1);
    
    openData{i - 2, 1} = opens;
    highData{i - 2, 1} = highs;
    lowData{i - 2, 1} = lows;
    closeData{i - 2, 1} = closes;
    volumeData{i - 2, 1} = volume;
    timeData{i - 2, 1} = T;    
    masterData{i - 2, 1} = allData;
    
end

%% RESIZE DATA BASED ON SMALLEST SET

minSize = min(sizes);

for i = 1:listSize
    
    A = openData{i};
    B = highData{i};
    C = lowData{i};
    D = closeData{i};
    E = volumeData{i};
    F = timeData{i};
    G = masterData{i};

    openData_f{i, 1} = A([1:minSize], :);
    highData_f{i, 1} = B([1:minSize], :);
    lowData_f{i, 1} = C([1:minSize], :);
    closeData_f{i, 1} = D([1:minSize], :);
    volumeData_f{i, 1} = E([1:minSize], :);
    timeData_f{i, 1} = F([1:minSize], :);
    masterData_f{i, 1} = G([1:minSize], :);
end

clear A B C D E F G i;
clear opens highs lows closes volumes T;
clear info timeVec allData sizes;

cd '../../../src'









