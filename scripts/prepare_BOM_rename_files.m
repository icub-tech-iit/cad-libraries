clear all
close all
clc

%% Constants

global numberOfLinesInTheExcelBOM
global excelBOMRangeWhereAddLines
global documentationOutputFolderName
global documentationInputFolderPath
global ExcelOutputFileStartingLine
global aliasColumnInBOMTable

numberOfLinesInTheExcelBOM = 16;
excelBOMRangeWhereAddLines = 'A25:L25';
documentationOutputFolderName = 'documentation';
ExcelOutputFileStartingLine = 10;
aliasColumnInBOMTable = 4;

wingstDatasource = "wingst ODBC driver IIT";
wingstUsername = "wingstRO";
wingstPassword = "wingstRO";
caseBomFromWingst = 1;
caseBomFromCreo = 2;
caseRemoveItemsFromSimplifiedBOM = 3;
caseOpenWingstConnection = 1;
caseDontOpenWingstConnection = 2;

%% Main

msg = "Do you want to open WINGST connection?";
opts = ["Yes" "No"];
choiceWingstConnection = menu(msg,opts);

switch choiceWingstConnection
   case caseOpenWingstConnection
      wingstConnection = database(wingstDatasource,wingstUsername,wingstPassword);
   case caseDontOpenWingstConnection
      wingstConnection = '';
   otherwise
      error('No correct selection has been provided.')
end

msg = "Select what you want to do";
opts = ["I have a BOM from WINGST and I want to rename the production files" "I have a simplified BOM from CREO, I want to rename files and prepare the production BOM" "I want to remove items from the Creo simplified BOM that are already in a production BOM"];
choiceOperation = menu(msg,opts);

switch choiceOperation
   case caseBomFromWingst
      prepareDocumentationForBomFromWingst()
   case caseBomFromCreo
      prepareDocumentationForBomFromCreoAndFillProductionBom(wingstConnection, false)
    case caseRemoveItemsFromSimplifiedBOM
      prepareDocumentationForBomFromCreoAndFillProductionBom(wingstConnection, true)
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
    
    for j = ExcelOutputFileStartingLine : ExcelOutputFileStartingLine + numberOfItems - 1
        aliasAsString = inputTable{j, aliasColumnInInputTable};
        revisionAsString = inputTable{j, revisionColumnInInputTable};
        revisionAsString = checkZeroRevision(revisionAsString);
        
        copyAndRenameProductionFiles(aliasAsString, revisionAsString)
    end
end


%% BOM from Creo section

function prepareDocumentationForBomFromCreoAndFillProductionBom(wingstConnection, alsoRemoveItems)

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

    if alsoRemoveItems
        table = removeItemsAlreadyPresentInAnotherExcelFile(table);
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

        if ~ isempty(wingstConnection)
            code = retrieveWingstCodeFromAlias(wingstConnection, aliasAsString);
            xlswrite(excelOutputTableFileWithPath, code, 'Sheet1', join(['C', num2str(i+ExcelOutputFileStartingLine)]))
        end

        copyAndRenameProductionFiles(aliasAsString, revisionAsString)

    end
end


%% Functions


function table = removeItemsAlreadyPresentInAnotherExcelFile(table)
    global ExcelOutputFileStartingLine
    global aliasColumnInBOMTable
    
    numberOfItems = length(table)-1;

    [excelTableName,pathTableName] = uigetfile({'*.xlsx';'*.xlsx'},'Select the Excel table containing the items to remove. The table must follow the production BOM format');

    tableWithItemsToRemove = readcell(join([pathTableName, excelTableName]));
    maximumNumberOfItemsToCheckInBOMTable = length(tableWithItemsToRemove) - ExcelOutputFileStartingLine;


    i = 2;
    while  i <= numberOfItems
        aliasAsString = table{i, 3};
        loopCondition = true;
        j = 1;

        while loopCondition
            aliasItemsToRemoveAsString = tableWithItemsToRemove{j + ExcelOutputFileStartingLine, aliasColumnInBOMTable};
            if ismissing(aliasItemsToRemoveAsString)
                break
            end
            
            if aliasItemsToRemoveAsString == aliasAsString
                table(i,:) = [];
                numberOfItems = numberOfItems - 1;
                i = i - 1;
                loopCondition = false;
            end

            if aliasItemsToRemoveAsString == "Alias" || j >= maximumNumberOfItemsToCheckInBOMTable
                loopCondition = false;
            end

            j = j + 1;
        end

        i = i + 1;
       
    end

end

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


function copyAndRenameFile(originalFileName, modifiedFileName)

    global documentationOutputFolderName
    global documentationInputFolderPath

    originalFileNameWithDirectory = join([documentationInputFolderPath, originalFileName]);
    if isfile(originalFileNameWithDirectory)
        outputFileNameWithDirectory = join([documentationInputFolderPath, documentationOutputFolderName, '\', modifiedFileName]);
        copyfile(originalFileNameWithDirectory, outputFileNameWithDirectory);
    end
end

function code = retrieveWingstCodeFromAlias(wingstConnection, alias)
    aliasForQuery = join(['"', alias, '"']);
    selectquery = join(['SELECT * FROM anamag WHERE mag_alias = ', aliasForQuery]);
    data_alias = select(wingstConnection,selectquery);
    code = data_alias.mag_id;
end
