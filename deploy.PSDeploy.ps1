<#
This is a PSDeploy Script file
https://github.com/RamblingCookieMonster/PSDeploy

NOTE: Change the Repository Parameter as needed!
    See https://bit.ly/2TRHVF6 for details, under "appveyor.yml"
#>

$Repository = "PSGallery" # https://github.com/RamblingCookieMonster/PSDeploy/blob/master/PSDeploy/PSDeployScripts/PSGalleryModule.ps1

Write-Output "  Publishing $ENV:BHProjectName--->"
Write-Output "Attempting to publish to $Repository..."

# https://psdeploy.readthedocs.io/en/latest/PSDeploy-Configuration-Files/
if($ENV:BHProjectName -and (Test-Path -Path ".\output\$ENV:BHProjectName"))
{
    Deploy Module {                                 # Deployment name
        By PSGalleryModule {                        # Deployment type
            FromSource output\$ENV:BHProjectName    # One or more sources to deploy. These are specific to your DeploymentType
            To $Repository                          # One or more destinations to target for deployment. These are specific to a DeploymentType
            WithOptions @{                          # Deployment options hash table to pass as parameters to DeploymentType script.
                ApiKey = $ENV:NugetApiKey
            }
        }
    }
}
