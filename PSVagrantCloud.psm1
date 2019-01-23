$FunctionFolders = @('Public','Private','Classes')
ForEach ($Folder in $FunctionFolders)
{
    $FolderPath = Join-Path -Path $PSScriptRoot -ChildPath $Folder
    if (Test-Path -Path $FolderPath)
    {
        Write-Verbose -Message "Importing from $Folder"
        $Functions = Get-ChildItem -Path $FolderPath -Filter '*.ps1'
        ForEach ($Function in $Functions)
        {
            Write-Verbose -Message "Importing $($Function.BaseName)"
            . $($Function.FullName)
        }
    }
}

$PublicFunctions = (Get-ChildItem -Path "$PSScriptRoot\Public" -Filter '*.ps1').BaseName
Export-ModuleMember -Function $PublicFunctions