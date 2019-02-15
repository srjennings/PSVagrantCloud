[cmdletbinding()]
param (
    [string]$Task = 'Default',
    [ValidateSet("Minor","Major","Patch")]
    [string]$ModuleVersion = 'Patch' # We default to Patch just in case
)

$global:ModuleVersionType = $ModuleVersion

Write-Output "
** ---Build Task '$Task' Starting--- **
"
if ($Task -eq 'Clean') {
    Invoke-Build $Task -Result Result

if ($Result.Error){
    exit 1
}
else {
    exit 0
}
}
else {
    Write-Output "Installing Dependencies for Build"
    # Install dependencies
    Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
    Install-Module InvokeBuild, PSDeploy, BuildHelpers, PSScriptAnalyzer, PlatyPS -force -Scope CurrentUser
    Install-Module Pester, PowerShellGet -Force -SkipPublisherCheck -Scope CurrentUser -AllowClobber
    
    Write-Output "Importing Dependencies for Build"
    # Import Modules
    Import-Module InvokeBuild, BuildHelpers, PSScriptAnalyzer
    
    Write-Output "Setting Build Parameters"
    Set-BuildEnvironment -Force
    
    Write-Output "Beginning Invoke-Build Sequence"
    # Invoke-Build will now start looking to the module build file for tasks
    Invoke-Build $Task -Result Result
    
    if ($Result.Error){
        exit 1
    }
    else {
        exit 0
    }
}
