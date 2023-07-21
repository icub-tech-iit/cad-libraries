%% This script creates a connection to the WINGST database and creates a 
%% CSV table that contains a list of items that are included in a top-level
%% assembly but have not been paid in any job ("commessa").
%%
%% Author: Luca Fiorio
%% Date: 20 July 2023


clear all
close all
clc

%% WINGST connection configuration parameters

wingstDatasource = "wingst ODBC driver IIT";
wingstUsername = "wingstRO";
wingstPassword = "WriteMe";
caseOpenWingstConnection = 1;
caseDontOpenWingstConnection = 2;

%% Script variables

% Code and revision of the BOM of the complete assembly
BOMCode = 3797;
BOMRevision = 'B';

% Code of the jobs ("commesse") used to build the sub-assemblies
jobIds = [2379,2381,2383,2411,2412,2413,2366];

quantityThresholdUnderWhichDeleteRows = 0;

%% Main

msg = "Do you want to proceed opening the WINGST connection?";
opts = ["Yes" "No"];
choiceWingstConnection = menu(msg,opts);
switch choiceWingstConnection
   case caseOpenWingstConnection
      wingstConnection = database(wingstDatasource,wingstUsername,wingstPassword);
   case caseDontOpenWingstConnection
      wingstConnection = '';
      error('Can not continue without WINGST connection.')
   otherwise
      error('No correct selection has been provided.')
end

BOMTable = retreiveCodesFromBOM(wingstConnection, BOMCode, BOMRevision);

numberOfJobs = length(jobIds);
tableOfUsedCodes = table();
for i = 1:numberOfJobs
    jobId = jobIds(i);
    table = retrieveActiveItemsFromJobId(wingstConnection, jobId);
    tableOfUsedCodes = [tableOfUsedCodes;table];
end

differenceTable = updateQuantityInBOMTableSubtractingAlreadyUsedCodesInJobs(BOMTable, tableOfUsedCodes);
differenceTable = deteleRowOfItemsWithQuantityUnderThreshold(differenceTable, quantityThresholdUnderWhichDeleteRows);
tableWithDescriptions = addDescriptionToTableCodes(wingstConnection, differenceTable);
writetable(tableWithDescriptions,'residualBOM.csv')


%% Functions
function differenceTable = updateQuantityInBOMTableSubtractingAlreadyUsedCodesInJobs(originalTable, tableOfItemsToDelete)
    numberOfItemsToCheck = height(tableOfItemsToDelete);
    for i = 1:numberOfItemsToCheck
        mag_idToCheck = tableOfItemsToDelete.jd_bd_mag_id(i);
        revisionToCheck = char(tableOfItemsToDelete.jd_bd_mag_id_revisione(i));
        quantityToRemove = tableOfItemsToDelete.jd_qta_pag(i);
        rowIndexOfSameCode = find(originalTable.bd_mag_id==mag_idToCheck & matches(originalTable.bd_mag_id_revisione, revisionToCheck));
        quantityInOriginalTable = originalTable(rowIndexOfSameCode,:).bd_qta;
        residualQuantity = quantityInOriginalTable - quantityToRemove;
        originalTable.bd_qta(rowIndexOfSameCode) = residualQuantity;
    end
    differenceTable = originalTable;
end


function table = retrieveActiveItemsFromJobId(wingstConnection, jobId)
    selectquery = join(['SELECT jd_bd_mag_id, jd_bd_mag_id_revisione, jd_qta_pag, jd_stato FROM job_details WHERE jd_jh_id = ', num2str(jobId)]);
    table = select(wingstConnection,selectquery);
    table(ismember(table.jd_stato, 1),:)=[];
end


function code = retrieveWingstCodeFromAlias(wingstConnection, alias)
    aliasForQuery = join(['"', alias, '"']);
    selectquery = join(['SELECT * FROM anamag WHERE mag_alias = ', aliasForQuery]);
    data_alias = select(wingstConnection,selectquery);
    code = data_alias.mag_id;
end


function table = retreiveCodesFromBOM(wingstConnection, BOMCode, BOMRevision)
    revisionForQuery = join(['"', BOMRevision,'"']);
    selectquery = join(['SELECT bd_mag_id, bd_mag_id_revisione, bd_qta FROM bom_details WHERE bd_bh_mag_id =', num2str(BOMCode), ' AND bd_bh_revisione = ', revisionForQuery]);
    table = select(wingstConnection,selectquery);
end

function description = retrieveWingstDescriptionFromCode(wingstConnection, code, revision)
    if revision(1,1) == ""
        selectquery = join(['SELECT mag_descri1 FROM anamag WHERE mag_id = ', num2str(code), ' AND mag_code_revision = " "']);
    else
        revisionForQuery = join(['"', char(revision),'"']);
        selectquery = join(['SELECT mag_descri1 FROM anamag WHERE mag_id = ', num2str(code), ' AND mag_code_revision = ', revisionForQuery]);
    end
    description = select(wingstConnection,selectquery);
end

function tableWithDescriptions = addDescriptionToTableCodes(wingstConnection, table)
    descriptionsArray = {};
    numberOfCodes = height(table);
    for i = 1:numberOfCodes
        code = table.bd_mag_id(i);
        revision = table.bd_mag_id_revisione(i);
        description = retrieveWingstDescriptionFromCode(wingstConnection, code, revision).mag_descri1;
        descriptionsArray{end+1} = description;
    end
    descriptionsTable = cell2table(descriptionsArray', "VariableNames",["Description"]);
    tableWithDescriptions = [table descriptionsTable];
end

function BOMTable = deteleRowOfItemsWithQuantityUnderThreshold(BOMTable, threshold)
    BOMTable(BOMTable.bd_qta <= threshold,:)=[];
end
