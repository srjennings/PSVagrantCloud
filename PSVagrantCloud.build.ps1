<#
*** How to Use **
Run `invoke-build ?` from the root directory to determine what each tasks does
This file is useless without first running .\build.ps1 -task 'taskname' [-ModuleVersion]

** IMPORTANT **
Case Sensitivity is Important for the 'CreateDocs' task.
This is because PlatyPS cares about this.
Ensure that testing is done thoroughly on this build script.

** Thank you **
Several portions of this script were used from the following people:
KevinMarquette, Josh Duffney

Thank you!
#>

#requires -Modules InvokeBuild, PSDeploy, BuildHelpers, PSScriptAnalyzer, PlatyPS, Pester
$Script:ModuleName = $Env:BHProjectName
$Script:Source = Join-Path -Path $BuildRoot -ChildPath $ModuleName
$Script:Output = Join-Path -Path $BuildRoot -ChildPath 'output'
$Script:Destination = Join-Path -Path $Script:Output -ChildPath $Script:ModuleName
$Script:ModulePath = Join-Path -Path $Script:Destination -ChildPath "$Script:ModuleName.psm1"
$Script:ManifestPath = Join-Path -Path $Script:Destination -ChildPath "$Script:ModuleName.psd1"
$Script:Imports = ( 'Private', 'Public' )
$Script:TestFile = "$PSScriptRoot\output\TestResults_PS$PSVersion`_$TimeStamp.xml"
$Script:HelpRoot = Join-Path -Path $Output -ChildPath 'docs'
$Script:Repository = "PSGallery"
$Script:GalleryVersionFile = Join-Path -Path $Script:Output -ChildPath 'GalleryVersion.xml'

Task Default Clean, Build, Pester, UpdateSource, Publish
Task Build CopyToOutputFolder, BuildPSM1, BuildPSD1
Task Local Build, Pester, UpdateSource
Task Pester Build, Tests
Task CreateDocs Pester, ImportModule, CreateMarkdownHelp, CreateExternalHelp, UpdateSource

#function TaskX($Name, $Parameters) {task $Name @Parameters -Source $MyInvocation}

# Synopsis: Removes './output/' folder
Task Clean {
    If (Test-Path $Output)
    {
        $null = Remove-Item $Output -Recurse -ErrorAction Ignore
    }
}

# Synopsis: Runs Pester tests
Task Tests {
    $TestResults = Invoke-Pester -Path Tests -PassThru -OutputFormat 'NUnitXml' -OutputFile $testFile
    if ($TestResults.FailedCount -gt 0)
    {
        Write-Error "Failed [$($TestResults.FailedCount)] Pester tests"
    }
}

# Synopsis: Copies all files to `./output/` folder
Task CopyToOutputFolder {
    Write-Output "  Creating directory [$Script:Destination]"
    New-Item -Type Directory -Path $Script:Destination -ErrorAction Ignore | Out-Null

    Write-Output "  Files and directories to be copied from source [$Script:Source]"

    Get-ChildItem -Path $Script:Source |
        Copy-Item -Destination $Script:Destination -exclude '*.ps[dm]1' -Recurse -Force -PassThru | # We filter .psd1 and .psm1 files because we'll build them
        ForEach-Object {"   Creating file: [{0}]" -f $_.fullname.replace($PSScriptRoot, '')}

}

# Synopsis: Builds .psm1 file by dot-sourcing the .ps1 files as functions
Task BuildPSM1 {
    [System.Text.StringBuilder]$StringBuilder = [System.Text.StringBuilder]::new()
    [void]$StringBuilder.AppendLine("# This file is generated with Invoke-Build...")
    foreach ($folder in $Script:Imports)
    {
        [void]$StringBuilder.AppendLine("Write-Verbose `"Importing from [`$PSScriptRoot\$folder]`"")
        if (Test-Path "$Script:Source\$folder")
        {
            $fileList = Get-ChildItem "$Script:Source\$folder" -Filter '*.ps1'
            Write-Output "  Grabbing Function Files from $folder"
            foreach ($function in $fileList)
            {
                $importName = "$folder\$($function.Name)"
                Write-Output "  Found File $importName"
                [void]$StringBuilder.AppendLine( ". `"`$PSScriptRoot\$importName`"")
            }
        }
    }

    [void]$StringBuilder.AppendLine("")

    [void]$StringBuilder.AppendLine("`$PublicFunctions = (Get-ChildItem -Path `"`$PSScriptRoot\Public`" -Filter '*.ps1').BaseName")
    [void]$StringBuilder.AppendLine("Export-ModuleMember -Function `$PublicFunctions")

    Write-Output "  Creating module file [$Script:ModulePath]"
    Set-Content -Path $Script:ModulePath -Value $stringbuilder.ToString()
}

# Synopsis: Queries the PSGallery and dumps it to a file
Task QueryPSGalleryVersion @{
    If     = (-Not ( Test-Path "$output\version.xml" ) )
    Before = 'BuildPSD1'
    Jobs   = {
            $galleryVersion = Get-NextPSGalleryVersion -Name $ModuleName # If no module is found on PSGallery, returns '0.0.1'
            $galleryVersion | Export-Clixml -Path "$GalleryVersionFile"
        }
}

# Synopsis: Builds PSD file for Module and bumps versions
Task BuildPSD1 @{
    Jobs    = {

        Write-Output "  Update [$ManifestPath]"
        Copy-Item "$Script:Source\$ModuleName.psd1" -Destination $ManifestPath

        $functions = Get-ChildItem "$ModuleName\Public\" -Filter "*.ps1" | Where-Object { $_.name -notmatch 'Tests'} | Select-Object -ExpandProperty basename
        Set-ModuleFunctions -Name $ManifestPath -FunctionsToExport $functions

        $bumpVersionType = $global:ModuleVersionType

        # Bump the module version
        $version = [version] (Get-Metadata -Path $manifestPath -PropertyName 'ModuleVersion')
        Write-Output "  Detected version $version"
        $galleryVersion = Import-Clixml -Path "$GalleryVersionFile"
        if ( $version -lt $galleryVersion )
        {
            $version = $galleryVersion
        }
        Write-Output "  Bumping [$bumpVersionType] version [$version]"
        $version = [version] (Step-Version $version -Type $bumpVersionType)
        Write-Output "  Using version: $version"

        Update-Metadata -Path $ManifestPath -PropertyName 'ModuleVersion' -Value $version
    }
}

# Synopsis: Updates existing local psd1 copy
Task UpdateSource {
    Copy-Item $ManifestPath -Destination "$Script:Source\$ModuleName.psd1"
}

# Synopsis: Runs PSDeploy and publishes to specified Repository
Task Publish {
    if (
        $ENV:BHBuildSystem -ne 'Unknown' -and
        $ENV:BHBranchName -eq "master" -and
        $ENV:BHCommitMessage -match '!publish'
    )
    {
        $Params = @{
            Path        = $BuildRoot
            Force       = $true
        }

        Invoke-PSDeploy @Verbose @Params
    }
    else
    {
        Write-Output "Skipping publishing: To publish: `n" +
        "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
        "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +
        "`t* Your commit message includes '!publish' (Current: $ENV:BHCommitMessage)"
    }
}

# Synopsis: Imports Module to local session from filesystem
Task ImportModule {
    if ( -Not ( Test-Path $ManifestPath ) )
    {
        "  Module [$ModuleName] is not built, cannot find [$ManifestPath]"
        Write-Error "Could not find module manifest [$ManifestPath]. You may need to build the module first"
    }
    else
    {
        if (Get-Module $ModuleName)
        {
            "  Unloading Module [$ModuleName] from previous import"
            Remove-Module $ModuleName
        }
        "  Importing Module [$ModuleName] from [$ManifestPath]"
        Import-Module $ManifestPath -Force
    }
}

# Synopsis: Creates Markdown Help in './docs/'
Task CreateMarkdownHelp @{
    Partial = $true
    Inputs  = {Get-ChildItem "$ModuleName\Public\*.ps1"}
    Outputs = {
        process
        {
            Get-ChildItem $_ | ForEach-Object {'{0}\{1}.md' -f $HelpRoot, $_.basename}
        }
    }
    Jobs    = 'ImportModule', {
        process
        {
            $null = New-Item -Path $HelpRoot -ItemType Directory -ErrorAction SilentlyContinue
            $mdHelp = @{
                #ModuleName            = $script:ModuleName
                OutputFolder          = $HelpRoot
                AlphabeticParamsOrder = $true
                Verbose               = $true
                Force                 = $true
                Command               = (Get-Item $_ | ForEach-Object basename)
            }
            New-MarkdownHelp @mdHelp | ForEach-Object fullname
        }
    }
}

# Synopsis: Creates External Help xml file in './en-us/'
Task CreateExternalHelp  @{
    Inputs  = {Get-ChildItem $HelpRoot -Recurse -File}
    Outputs = "$Destination\en-us\$ModuleName-help.xml"
    Jobs    = 'CreateMarkdownHelp', {
        New-ExternalHelp -Path $HelpRoot -OutputPath "$Destination\en-us" -force | ForEach-Object fullname
    }
}