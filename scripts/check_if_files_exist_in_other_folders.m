%% This script checks if any of the files contained in `folder 1`
%% are found also in `folder 2` (or any of its subfolders.
%% The script then generates a report with the duplicated files. 
%%
%% Author: Luca Fiorio
%% Date: 20 July 2023


clear all
close all
clc

% Select Folder 1 (Folder containing files to be checked)
folder1 = uigetdir('', 'Select Folder with Files to Check');

% Check if user canceled folder selection
if folder1 == 0
    disp('Operation canceled by user.');
    return;
end

% Select Folder 2 (Folder with Subfolders to check for the same files)
folder2 = uigetdir('', 'Select Folder with Subfolders to check for the same files');

% Check if user canceled folder selection
if folder2 == 0
    disp('Operation canceled by user.');
    return;
end

% Get a list of all files in Folder 1
filesFolder1 = dir(fullfile(folder1, '*.*'));

% Initialize a report
report = cell(0);

% Check each file in Folder 1
for i = 1:length(filesFolder1)
    filename = filesFolder1(i).name;
    
    % Get the full path of the file in Folder 1
    filePathFolder1 = fullfile(folder1, filename);
    
    % Check if the file exists in Folder 2 or its subfolders
    [fileExists, filePathFolder2] = checkFileExists(fullfile(folder2, '**', filename));
    
    % Include in the report only if the file is found in Folder 2
    if fileExists
        report{end+1} = sprintf('File: %s, Exists in: %s', filePathFolder1, filePathFolder2);
    end
end

% Display the report in the command window
if ~isempty(report)
    disp('Comparison Report (Files Found in Folder 2):');
    disp(report);
    % Save the report to a text file
    saveReportToFile(report, 'Comparison_Report.txt');
else
    disp('No matching files found in Folder 2.');
end

% Function to check if a file exists in a directory or its subdirectories
function [exists, filePath] = checkFileExists(filePath)
    files = dir(filePath);
    exists = any(~[files.isdir]);
    
    if exists
        filePath = fullfile(pwd, files(1).folder);
    else
        filePath = 'Not found';
    end
end

% Function to save the report to a text file
function saveReportToFile(report, filename)
    fid = fopen(filename, 'w');
    if fid == -1
        error('Unable to create the report file.');
    end
    
    for i = 1:length(report)
        fprintf(fid, '%s\n', report{i});
    end
    
    fclose(fid);
    disp(['Comparison Report saved to ' filename]);
end
