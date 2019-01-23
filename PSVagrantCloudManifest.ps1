$manifest = @{
    Path            = '.\PSVagrantCloud.psd1'
    RootModule      = '.\PSVagrantCloud.psm1'
    Author          = 'Steve Jennings <steven@automatingops.com>'
    ModuleVersion   = '1.0'
    FunctionsToExport  = @(
        'Find-VagrantCloudBox',
        'Get-VagrantCloud2FACode',
        'Get-VagrantCloudAPIToken',
        'Get-VagrantCloudBox',
        'Get-VagrantCloudBoxVersion',
        'Get-VagrantCloudOrganization',
        'Get-VagrantCloudProvider',
        'New-VagrantCloudAPIToken',
        'New-VagrantCloudBox',
        'New-VagrantCloudBoxVersion',
        'New-VagrantCloudProvider',
        'Remove-VagrantCloudAPIToken',
        'Remove-VagrantCloudBox',
        'Remove-VagrantCloudBoxVersion',
        'Remove-VagrantCloudProvider',
        'Set-VagrantCloudBox',
        'Set-VagrantCloudBoxProvider',
        'Set-VagrantCloudBoxVersion'
    )
}

[array]::sort($manifest.FunctionsToExport)

New-ModuleManifest @manifest