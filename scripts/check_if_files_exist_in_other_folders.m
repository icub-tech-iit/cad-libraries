%% This script checks if any of the files contained in `folder 1`
%% are found also in `folder 2` (or any of its subfolders).
%% The script then generates a report with the duplicated files. 
%%
%% Author: Luca Fiorio
%% Date: 27 November 2023


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

% Initialize reports for files found and not found
reportFound = cell(0);
reportNotFound = cell(0);

% Check each file in Folder 1
for i = 1:length(filesFolder1)
    filename = filesFolder1(i).name;
    
    % Get the full path of the file in Folder 1
    filePathFolder1 = fullfile(folder1, filename);
    
    % Check if the file exists in Folder 2 or its subfolders
    [fileExists, filePathFolder2] = checkFileExists(fullfile(folder2, '**', filename));
    
    % Include in the corresponding report section
    if fileExists
        reportFound{end+1} = sprintf('File: %s, Exists in: %s', filePathFolder1, filePathFolder2);
    else
        reportNotFound{end+1} = sprintf('File: %s, Not found in: %s', filePathFolder1, folder2);
    end
end

% Display the reports in the command window
% Display the reports in the command window
if ~isempty(reportFound)
    disp('Files Found in Folder 2:');
    for i = 1:numel(reportFound)
        fprintf('%s\n', reportFound{i});
    end
end

if ~isempty(reportNotFound)
    disp(' ');
    disp('Files Not Found in Folder 2:');
    for i = 1:numel(reportNotFound)
        fprintf('%s\n', reportNotFound{i});
    end
end

% Save the reports to text files
saveReportToFile(reportFound, 'Found_Report.txt');
saveReportToFile(reportNotFound, 'NotFound_Report.txt');

% Function to check if a file exists in a directory or its subdirectories
function [exists, filePath] = checkFileExists(filePath)
    files = dir(filePath);
    exists = any(~[files.isdir]);
    
    if exists
        filePath = files(1).folder;
    else
        filePath = 'Not found';
    end
end

% Function to save a report to a text file
function saveReportToFile(report, filename)
    if ~isempty(report)
        fid = fopen(filename, 'w');
        if fid == -1
            error('Unable to create the report file.');
        end

        for i = 1:length(report)
            fprintf(fid, '%s\n', report{i});
        end

        fclose(fid);
        disp(['Report saved to ' filename]);
    end
end
