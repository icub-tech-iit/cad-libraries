
<#
.HISTORY
XX    YYYYMMDD   Author    Description
01    20160811   alberto   first test
02    20170218   alberto   deployed working script

.DESCRIPTION
1. clear all variables
2. find out where the script is
3. get the location of the repo root
4. create a temporary folder in output_dir
5. given a part code find where it is in the repo

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


Function Split-ByLength{
    <#
    .SYNOPSIS
    Splits string up by Split length.

    .DESCRIPTION
    Convert a string with a varying length of characters to an array formatted to a specific number of characters per item.

    .EXAMPLE
    Split-ByLength '012345678901234567890123456789123' -Split 10

    0123456789
    0123456789
    0123456789
    123

    .LINK
    http://stackoverflow.com/questions/17171531/powershell-string-to-array/17173367#17173367
    #>

    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$InputObject,

        [int]$Split=10
    )
    begin{}
    process{
        foreach($string in $InputObject){
            $len = $string.Length

            $repeat=[Math]::Floor($len/$Split)

            for($i=0;$i-lt$repeat;$i++){
                #Write-Output ($string[($i*$Split)..($i*$Split+$Split-1)])
                Write-Output $string.Substring($i*$Split,$Split)
            }
            if($remainder=$len%$split){
                #Write-Output ($string[($len-$remainder)..($len-1)])
                Write-Output $string.Substring($len-$remainder)
            }
        }        
    }
    end{}
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
$script_path = $MyInvocation.MyCommand.Definition | Split-Path
#$datetime = Get-Date -UFormat "%Y%m%d_%H%M%S"


# move up four levels to get the iCubHardware root 
$root_dir = $script_path | Split-Path | Split-Path | Split-Path | Split-Path
# then build the names of the folder and of the trail file
$output_file = $script_path + '\open_drawing_mapkey.pro'

<#
where can I search?
_____________________________________________________________________________
create a list of allowed paths (recepie from [2] testing for directory existence) using recepie from [3] to join strings
#>

$folders = '\public\icub1_icub2', `
           '\collaborations\icub2-5', `
           '\sandbox',
           '\collaborations\cer' | foreach { $root_dir + $_ }


New-Item $output_file -Value "mapkey open_drawing_mapkey \`n" -ItemType file -force
Add-Content $output_file 'mapkey(continued) ~ Activate `main_dlg_cur` `main_dlg_cur`;\' 
Add-Content $output_file 'mapkey(continued) ~ Command `ProCmdModelOpen` ;\'
Add-Content $output_file 'mapkey(continued) ~ Activate `file_open` `file_open`;\'
Add-Content $output_file 'mapkey(continued) ~ Update `file_open` `Inputname` \'

$object_code = Get-Content ($script_path + '\model_tree.txt') | Select -Index 2
# trim whitespaces
$object_code = $object_code.Trim()
# get true object code by removing file extension (last 4 characters of the filename)
$object_code = $object_code -replace ".{4}$"
# build model file names and drawing file names
$drawing_name = $object_code + '.drw.1'

$drawing_not_found = $true
# look in all searchable folders for the given drawing using recepies [2] and [4] for retrieving full paths

Foreach ($folder in $folders){
    If (Test-Path $folder){
        $drawing_result = Get-ChildItem –Path $folder -Filter $drawing_name -Recurse -Force | % {$_.FullName}
        # if the drawing is found set the corresponding warning flag to false and exit the loop
        if ($drawing_result -ne $null) {$drawing_not_found = $false
                                        break}
    }
}

# create a copy of $drawing_result and modify it to the mapkey file syntax
$drawing_result_in_pro = $drawing_result | % {$_.replace('\', '\\')} | % {'`' + $_ + '`;'} 
Split-ByLength $drawing_result_in_pro -Split 50| % {'mapkey(continued) ' + $_ + '\'} | Add-Content $output_file
Split-ByLength $drawing_result_in_pro -Split 50| % {'mapkey(continued) ' + $_ + '\'} | Write-Host
Add-Content $output_file 'mapkey(continued) ~ Activate `file_open` `Inputname`;'

Clean-Memory