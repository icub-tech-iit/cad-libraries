clear all
close all
clc

%% Constants

global numberOfLinesInTheExcelBOM
global excelBOMRangeWhereAddLines
global excelInputTableName
global excelOutputTableName
global documentationOutputFolderName
global documentationInputFolderName

numberOfLinesInTheExcelBOM = 16;
excelBOMRangeWhereAddLines = 'A25:L25';
excelInputTableName = 'Book1.xlsx';
excelOutputTableName = 'BOM.xlsx';
documentationOutputFolderName = 'documentation';
documentationInputFolderName = 'data';

ExcelOutputFileStartingLine = 10;


%% Main

table = readcell(excelInputTableName);
quantityCOlumnIsCorrect = all(table{1,2} == 'QUANTITY');

if ~quantityCOlumnIsCorrect
    error('The Excel table is not compliant. Check the QUANTITY column.')
end


numberOfItems = length(table)-1;

if numberOfItems > numberOfLinesInTheExcelBOM
    addLines(numberOfItems - numberOfLinesInTheExcelBOM)
end

mkdir(documentationOutputFolderName)

for i = 1 : numberOfItems
    quantity = table{1+i, 2};
    aliasAsCell = table(1+i, 3);
    aliasAsString = table{1+i, 3};
    revisionAsCell = table(1+i, 4);
    revisionAsString = table{1+i, 4};
    
    % Convert revision to string if it is 0
    if revisionAsString == 0 
        revisionAsString = num2str(0);
    end
    
    xlswrite(excelOutputTableName, quantity, 'Sheet1', join(['H', num2str(i+ExcelOutputFileStartingLine)]))
    xlswrite(excelOutputTableName, aliasAsCell, 'Sheet1', join(['D', num2str(i+ExcelOutputFileStartingLine)]))
    xlswrite(excelOutputTableName, revisionAsCell, 'Sheet1', join(['E', num2str(i+ExcelOutputFileStartingLine)]))
    
    sourceDrawingFileName = join([aliasAsString, '.pdf']);
    sourceStepFileName = join([aliasAsString, '.stp']);
    
    outputDrawingFileName = join([aliasAsString, '_rev_', revisionAsString, '.pdf']);
    outputStepFileName = join([aliasAsString, '_rev_', revisionAsString, '.stp']);
    % Remove spaces (might be necessary)
    outputDrawingFileName = outputDrawingFileName(find(~isspace(outputDrawingFileName)));
    outputStepFileName = outputStepFileName(find(~isspace(outputStepFileName)));
    
    copyAndRenameFile (sourceDrawingFileName, outputDrawingFileName)
    copyAndRenameFile (sourceStepFileName, outputStepFileName)

end


%% Functions

function addLines(numberOfLinesToAdd)

    global excelBOMRangeWhereAddLines
    global excelOutputTableName

    excelTableFile = join([pwd, '\', excelOutputTableName]);
    excel = actxserver('Excel.Application');
    wb = excel.Workbooks.Open(excelTableFile);
    ws = wb.Worksheets.Item('Sheet1');
    
    for i = 1 : numberOfLinesToAdd
        ws.Range(excelBOMRangeWhereAddLines).Insert;
    end
    
    wb.Save;
    excel.Quit;
    delete(excel);

end


function copyAndRenameFile (originalFileName, modifiedFileName)

    global documentationOutputFolderName
    global documentationInputFolderName

    originalFileNameWithDirectory = join([pwd, '\', documentationInputFolderName, '\', originalFileName]);
    if isfile(originalFileNameWithDirectory)
        outputFileNameWithDirectory = join([pwd, '\', documentationOutputFolderName, '\', modifiedFileName]);
        copyfile(originalFileNameWithDirectory, outputFileNameWithDirectory);
    end
end
