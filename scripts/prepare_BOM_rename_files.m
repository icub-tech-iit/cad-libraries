clear all
close all
clc

%% Constants

global numberOfLinesInTheExcelBOM
global excelBOMRangeWhereAddLines
global documentationOutputFolderName
global documentationInputFolderPath
global ExcelOutputFileStartingLine

numberOfLinesInTheExcelBOM = 16;
excelBOMRangeWhereAddLines = 'A25:L25';
documentationOutputFolderName = 'documentation';
ExcelOutputFileStartingLine = 10;

caseBomFromWingst = 1;
caseBomFromCreo = 2;

%% Main
msg = "Select what you want to do";
opts = ["I have a BOM from WINGST and I want to rename the production files" "I have a simplified BOM from CREO, I want to rename files and prepare the production BOM"];
choice = menu(msg,opts);

switch choice
   case caseBomFromWingst
      prepareDocumentationForBomFromWingst()
   case caseBomFromCreo
      prepareDocumentationForBomFromCreoAndFillProductionBom()
   otherwise
      error('No correct selection has been provided.')
end


%% BOM from WINGST section

function prepareDocumentationForBomFromWingst()

    global documentationOutputFolderName
    global documentationInputFolderPath
    global ExcelOutputFileStartingLine
    
    aliasColumnInInputTable = 3;
    revisionColumnInInputTable = 4;
    
    [excelInputTableName,pathInputTableName] = uigetfile({'*.xlsx';'*.xlsx'},'Select input BOM table from WINGST. In the same folder there MUST be the pdf and step files.');
    
    inputTable = readcell(join([pathInputTableName, excelInputTableName]));
    
    maxTableLength = length(inputTable);
    
    for i = ExcelOutputFileStartingLine : maxTableLength
        cellIsEmpty = any(ismissing(inputTable{i, 1}));
        if cellIsEmpty
            break
        end
    end
    
    numberOfItems = inputTable{i-1, 1};
    
    documentationInputFolderPath = pathInputTableName;
    mkdir(join([documentationInputFolderPath, documentationOutputFolderName]));
    
    for j = ExcelOutputFileStartingLine : ExcelOutputFileStartingLine + numberOfItems
        aliasAsString = inputTable{j, aliasColumnInInputTable};
        revisionAsString = inputTable{j, revisionColumnInInputTable};
        revisionAsString = checkZeroRevision(revisionAsString);
        
        copyAndRenameProductionFiles(aliasAsString, revisionAsString)
    end
end


%% BOM from Creo section

function prepareDocumentationForBomFromCreoAndFillProductionBom()

    global numberOfLinesInTheExcelBOM
    global documentationInputFolderPath
    global documentationOutputFolderName
    global ExcelOutputFileStartingLine
    
    [excelInputTableName,pathInputTableName] = uigetfile({'*.xlsx';'*.xlsx'},'Select simplified input BOM table from Creo. In the same folder there MUST be the pdf and step files.');
    [excelOutputTableName,pathOutputTable] = uigetfile({'*.xlsx';'*.xlsx'},'Select output BOM table for production');

    excelOutputTableFileWithPath = join([pathOutputTable, excelOutputTableName]);

    documentationInputFolderPath = pathInputTableName;
    mkdir(join([documentationInputFolderPath, documentationOutputFolderName]));

    table = readcell(join([pathInputTableName, excelInputTableName]));
    quantityColumnIsCorrect = all(table{1,2} == 'QUANTITY');

    if ~quantityColumnIsCorrect
        error('The Excel table is not compliant. Check the QUANTITY column.')
    end

    numberOfItems = length(table)-1;

    if numberOfItems > numberOfLinesInTheExcelBOM
        numberOfLinesToAdd = numberOfItems - numberOfLinesInTheExcelBOM;
        addLines(excelOutputTableFileWithPath, numberOfLinesToAdd)
    end

    for i = 1 : numberOfItems
        quantity = table{1+i, 2};
        aliasAsCell = table(1+i, 3);
        aliasAsString = table{1+i, 3};
        revisionAsCell = table(1+i, 4);
        revisionAsString = table{1+i, 4};
        
        revisionAsString = checkZeroRevision(revisionAsString);

        xlswrite(excelOutputTableFileWithPath, quantity, 'Sheet1', join(['H', num2str(i+ExcelOutputFileStartingLine)]))
        xlswrite(excelOutputTableFileWithPath, aliasAsCell, 'Sheet1', join(['D', num2str(i+ExcelOutputFileStartingLine)]))
        xlswrite(excelOutputTableFileWithPath, revisionAsCell, 'Sheet1', join(['E', num2str(i+ExcelOutputFileStartingLine)]))

        copyAndRenameProductionFiles(aliasAsString, revisionAsString)

    end
end


%% Functions

function addLines(excelOutputTableFileWithPath, numberOfLinesToAdd)

    global excelBOMRangeWhereAddLines

    excel = actxserver('Excel.Application');
    wb = excel.Workbooks.Open(excelOutputTableFileWithPath);
    ws = wb.Worksheets.Item('Sheet1');
    
    for i = 1 : numberOfLinesToAdd
        ws.Range(excelBOMRangeWhereAddLines).Insert;
    end
    
    wb.Save;
    excel.Quit;
    delete(excel);

end


function revisionChecked = checkZeroRevision(revision)
    % Convert revision to string if it is 0
    if revision == 0 
        revisionChecked = num2str(0);
    else
        revisionChecked = revision;
    end
end


function copyAndRenameProductionFiles(aliasAsString, revisionAsString)
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


function copyAndRenameFile (originalFileName, modifiedFileName)

    global documentationOutputFolderName
    global documentationInputFolderPath

    originalFileNameWithDirectory = join([documentationInputFolderPath, originalFileName]);
    if isfile(originalFileNameWithDirectory)
        outputFileNameWithDirectory = join([documentationInputFolderPath, documentationOutputFolderName, '\', modifiedFileName]);
        copyfile(originalFileNameWithDirectory, outputFileNameWithDirectory);
    end
end
