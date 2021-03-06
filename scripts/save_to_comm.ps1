
<#
.HISTORY
XX    YYYYMMDD   Author    Description
01    20161014   alberto   first release



.DESCRIPTION
1. list all variables at the beginning of the script
2. find out where the script is running
3. get the location of the repo root
4. create a temporary folder in output_dir
5. generate a list of files to be processed by looking in the content of the $folders directory
6. build the corresponding strings and add them to the list of things to be exported
7. generate the trail file

Warning: the script only works if assemblies regenerate without failures.

.LINKS
[1] https://clan8blog.wordpress.com/2013/10/10/powershell-clean-up-after-yourself/
[2] https://www.experts-exchange.com/questions/26697043/Powershell-If-folder-exist-then-use-path-in-get-childitem.html
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
$root_dir = $script_path | Split-Path | Split-Path | Split-Path | Split-Path | Split-Path 
# then build the names of the folder and of the trail file
$output_dir = $root_dir + '\output_dir\temp_' + $datetime
$output_file = $output_dir + '\auto_trail.txt'
$log_file = $output_dir + '\log.txt'

<#
where can I search?
_____________________________________________________________________________
create a list of allowed paths (recepie from [2] testing for directory existence) using recepie from [3] to join strings
#>

$folders = '\collaborations\cer\setups\test_setup_20_new_torso', `
           '\collaborations\cer\setups\test_setup_19_new_mobile_base' | foreach { $root_dir + $_ }

# create the trail file with standard header and suppress output with recepie [5]
New-Item $output_file -Value "!trail file version No. 1600`n" -ItemType file -force > $null
Add-Content $output_file "!automatically generated file by the export_docs script"
# create the log file with standard header and suppress output with recepie [5]
New-Item $log_file -Value ("[INFO] job started at " + $datetime + "`n") -ItemType file -force > $null

<#
main object searching loop
_____________________________________________________________________________
1. generate a list of files to be processed by looking in the content of the $folders directory
2. build the corresponding strings and add them to the list of things to be exported
#>

$files = @()

Foreach ($folder in $folders){
    If (Test-Path $folder){
        $results = Get-ChildItem –Path $folder | % {$_.FullName}
        ForEach ($result in $results){
            <# format filename according to the Creo/ProE synthax. The Creo/ProE synthax requires:
            - folder names to begin and end with the '`' character
            - single slashes '\' to be replaced by double slashes '\\'#>
            $files +=  '`' + ($result.replace('\', '\\')) + '`'
        }
    }
}

<#
trail file export
_____________________________________________________________________________
parse all files in the variable $files and output corresponding trail commands
#>


# load EDU-COM converter
Add-Content $output_file '~ Select `main_dlg_cur` `appl_casc`'
Add-Content $output_file '~ Command `ProCmdRibbonOptionsDlg`'
Add-Content $output_file '~ Select `ribbon_options_dialog` `PageSwitcherPageList` 1 `LicLayout`'
Add-Content $output_file '~ Activate `ribbon_options_dialog` `LicLayout.RefBtn`'
Add-Content $output_file '~ Activate `ribbon_options_dialog` `LicLayout.ck.EDU_COM_Convert` 1'
Add-Content $output_file '~ Activate `ribbon_options_dialog` `OkPshBtn`'


# for each file, open, save, close and erase
ForEach($file in $files) {
    # open file
    Add-Content $output_file '~ Activate `main_dlg_cur` `main_dlg_cur`'
    Add-Content $output_file '~ Command `ProCmdModelOpen`'
    Add-Content $output_file ('~ Update `file_open` `Inputname` ' + $file)
    Add-Content $output_file '~ Activate `file_open` `Inputname`'
    # save
    Add-Content $output_file '~ Command `ProCmdModelSave`' 
    Add-Content $output_file '~ Activate `file_saveas` `OK`'
    Add-Content $output_file '~ Activate `storage_conflicts` `OK_PushButton`'
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