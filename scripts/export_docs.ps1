﻿<#
.HISTORY
XX    YYYYMMDD   Author    Description                                               Location (when the file was modified)
01    20160811   alberto   first preliminary release
02    20160919   alberto   major refacotring
                           solved wrong target drawing file name bug
                           added documentation 
03    20200805   luca      added condition to stop searching a file once has 
                           been found in one of the searchable directories           line 142

.DESCRIPTION
1. list all variables at the beginning of the script
2. find out where the script is running
3. get the location of the repo root
4. create a temporary folder in output_dir
5. given a code check if it is valid
6. if yes check if the corresponding model and drawings exist in the searchable directories
7. if yes build the string for the script file and add it to the export list
8. finally build the export script
if errors are found output the corresponding warning messages.

.LINKS
[1] https://clan8blog.wordpress.com/2013/10/10/powershell-clean-up-after-yourself/
[2] https://www.experts-exchange.com/questions/26697043/Powershell-If-folder-exist-then-use-path-in-get-childitem.html
[3] http://stackoverflow.com/questions/11648968/powershell-appending-strings
[4] http://stackoverflow.com/a/13128911
[5] http://stackoverflow.com/questions/5260125/whats-the-better-cleaner-way-to-ignore-output-in-powershell
#>

Function Clean-Memory {
    <#
    .SYNOPSIS
    Cleans memory after script execution

    .DESCRIPTION
    Removes variables created within the script.
    Stores the names of the variables at the initiation of the script in the $startup_variables list.
    All variables not listed will be deleted by the function.
    The function shall be called at the end of the script.

    .EXAMPLE
    Clean-Memory

    .LINK
    https://clan8blog.wordpress.com/2013/10/10/powershell-clean-up-after-yourself/
    #>
    
    Get-Variable |
    Where-Object { $startup_variables -notcontains $_.Name } |
    ForEach-Object {
    try { Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue}
    catch { }
    }
}

<# 
housekeeping
_____________________________________________________________________________
recepie for clearing varibles [1]
Store all the start up variables so you can clean up when the script finishes.
#>
if ($startup_variables){ 
    try {Remove-Variable -Name startup_variables  -Scope Global -ErrorAction SilentlyContinue }
    catch { }
}

New-Variable -force -name startup_variables -value ( Get-Variable | ForEach-Object { $_.Name } ) 

<#
where am I? when am I running?
_____________________________________________________________________________
- identify the path of the current script (as this might change depending on 
  where the repo is installed on different machines)
- get current time for temporary folder
#>
$script_path = $MyInvocation.MyCommand.Definition
$datetime = Get-Date -UFormat "%Y%m%d_%H%M%S"


# move up four levels to get the iCubHardware root 
$root_dir = $script_path | Split-Path | Split-Path
# then build the names of the folder and of the trail file
$output_dir = $root_dir + '\output_dir\temp_' + $datetime
$output_file = $output_dir + '\auto_trail.txt'
$log_file = $output_dir + '\log.txt'

<#
where can I search?
_____________________________________________________________________________
create a list of allowed paths (recepie from [2] testing for directory existence) using recepie from [3] to join strings
#>

$folders = 'C:\Users\msalvi\Documents\hardware\cad-mechanics'

# create the trail file with standard header and suppress output with recepie [5]
New-Item $output_file -Value "!trail file version No. 1600`n" -ItemType file -force > $null
Add-Content $output_file "!automatically generated file by the export_docs script"
# create the log file with standard header and suppress output with recepie [5]
New-Item $log_file -Value ("[INFO] job started at " + $datetime + "`n") -ItemType file -force > $null

<#
main object searching loop
_____________________________________________________________________________
1. load the list of files to be searched from the file "input_codes.txt"
2. check the the files comply with the iCub facility coding scheme
3. for each code look for the model the drawing
4. if the model and drawing are found build the relative strings and add them to the list of things to be exported
5. if not output the corresponding warning messages
#>



$object_codes = Get-Content (($script_path | Split-Path) + '\input_codes.txt')

$object_codes = $object_codes | foreach {if($_ -like '*_A_*' -Or `
                                            $_ -like '*_G_*' -Or `
                                            $_ -like '*_P_*' -Or `
                                            $_ -like '*_M_*' -Or `
                                            $_ -like '*_R_*') {$_}
                                            else {$err_str = "[ERROR] irregular object code: " + $_ + "`n"
                                                  Write-Host $err_str
                                                  Add-Content $log_file $err_str}
                                         }

# create an empty array for the model files
$model_files = @()
$target_model_files = @()
$drawing_files = @()
$target_drawing_files = @()

# main search loop on loaded valid object codes
foreach ($object_code in $object_codes) {
    $model_not_found = $true
    $drawing_not_found = $true
    # build model file names and drawing file names
    if($object_code -like '*_A_*'){$model_file_name = $object_code + '.asm.1'}
    elseif($object_code -like '*_G_*'){$model_file_name = $object_code + '.asm.1'}
    elseif($object_code -like '*_R_*'){$model_file_name = $object_code + '.asm.1'}
    else {$model_file_name = $object_code + '.prt.1'}
    $drawing_file_name = $object_code + '.drw.1'
    # look in all searchable folders for the given model and the given drawing
    Foreach ($folder in $folders){
        If ((Test-Path $folder) -And ($model_not_found)){
                $model_result = Get-ChildItem –Path $folder -Filter $model_file_name -Recurse -Force | % {$_.FullName}
                # if the model is found set the corresponding warning flag to false
                if ($model_result -ne $null) {$model_not_found = $false}
                $drawing_result = Get-ChildItem –Path $folder -Filter $drawing_file_name -Recurse -Force | % {$_.FullName}
                # if the drawing is found set the corresponding warning flag to false
                if ($drawing_result -ne $null) {$drawing_not_found = $false}
                                Write-Host $folder
                                Write-Host $model_result
                                Write-Host $drawing_result
                                Write-Host $model_not_found
                                Write-Host $drawing_not_found
        }
    }

    # if the model is not found output the corresponding warning messages
    if ($model_not_found) {$err_str = "[WARNING] model of " + $model_file_name + " not found in folder " + $folder
                           Write-Host $err_str
                           Add-Content $log_file $err_str}
    <# otherwise if the model is found build with the Creo/ProE synthax the model file name and the desired saving target location.
       The Creo/ProE synthax requires:
       - folder names to begin and end with the '`' character
       - single slashes '\' to be replaced by double slashes '\\'#>
    else{
         #Write-Host $model_result
         $model_files +=  '`' + ($model_result.replace('\', '\\')) + '`'
         $target_model_files +=  ('`' + $output_dir + '\' + $object_code + '`').replace('\', '\\')}
    # for the drawings do the same as for models
    if ($drawing_not_found) {$err_str = "[WARNING] drawing of " + $drawing_file_name + " not found"
                             Write-Host $err_str
                             Add-Content $log_file $err_str}
    else{$drawing_files +=  '`' + ($drawing_result.replace('\', '\\')) + '`'
         $target_drawing_files +=  ('`' + $output_dir + '\' + $object_code + '`').replace('\', '\\')}
}


# create the name of the output dir in the ProE/Creo format
$output_dir_in_pro = '`' + $output_dir.replace('\', '\\') + '`;'

# for each file, open, save as step, close and erase
for($i = 0; $i -lt $model_files.length; $i++) {
    # open file
    Add-Content $output_file '~ Activate `main_dlg_cur` `main_dlg_cur`'
    Add-Content $output_file '~ Command `ProCmdModelOpen`'
    Add-Content $output_file ('~ Update `file_open` `Inputname` ' + $model_files[$i])
    Add-Content $output_file '~ Activate `file_open` `Inputname`'
    # save as step
    Add-Content $output_file '~ Command `ProCmdModelSaveAs`'
    Add-Content $output_file '~ Open `file_saveas` `type_option`'
    Add-Content $output_file '~ Select `file_saveas` `type_option` 1 `db_539`'
    Add-Content $output_file ('~ Update `file_saveas` `Inputname` ' + $target_model_files[$i])
    Add-Content $output_file '~ Activate `file_saveas` `Inputname`'
    Add-Content $output_file '~ Activate `intf_export` `OkPushBtn`'
    # close window and erase not displayed    
    Add-Content $output_file '~ Command `ProCmdWinCloseGroup`'
    Add-Content $output_file '~ Command `ProCmdModelEraseNotDisp`'
    Add-Content $output_file '~ Activate `file_erase_nd` `ok_pb`'
}

# for each drawing, open, save as pdf, close and erase
for($i = 0; $i -lt $drawing_files.length; $i++) {
    # open file
    Add-Content $output_file '~ Activate `main_dlg_cur` `main_dlg_cur`'
    Add-Content $output_file '~ Command `ProCmdModelOpen`'
    Add-Content $output_file ('~ Update `file_open` `Inputname` ' + $drawing_files[$i])
    Add-Content $output_file '~ Activate `file_open` `Inputname`'
    # save as pdf (600 dpi resolution, grayscale, not opening file with reader)
    Add-Content $output_file '~ Command `ProCmdModelSaveAs`'
    Add-Content $output_file '~ Open `file_saveas` `type_option`'
    Add-Content $output_file '~ Select `file_saveas` `type_option` 1 `db_617`'
    Add-Content $output_file '~ Activate `file_saveas` `file_saveas`'
    Add-Content $output_file ('~ Update `file_saveas` `Inputname` ' + $target_drawing_files[$i])
    Add-Content $output_file '~ Activate `file_saveas` `Inputname`'
    Add-Content $output_file '~ Open `intf_profile` `pdf_export.pdf_raster_dpi`'
    Add-Content $output_file '~ Select `intf_profile` `pdf_export.pdf_raster_dpi` 1 `600`'
    Add-Content $output_file '~ Activate `intf_profile` `pdf_export.pdf_launch_viewer` 0'
    Add-Content $output_file '~ Activate `intf_profile` `OkPshBtn`'
    # close window and erase not displayed    
    Add-Content $output_file '~ Command `ProCmdWinCloseGroup`'
    Add-Content $output_file '~ Command `ProCmdModelEraseNotDisp`'
    Add-Content $output_file '~ Activate `file_erase_nd` `ok_pb`'    
}

#Add-Content $output_file '!Command to close Creo'
#Add-Content $output_file '~ Close `main_dlg_cur` `main_dlg_cur`'
#Add-Content $output_file '!Command ProCmdOSExit was pushed from the software.'
#Add-Content $output_file '~ FocusIn `UI Message Dialog` `yes`'
#Add-Content $output_file '~ Activate `UI Message Dialog` `yes`'

Clean-Memory
