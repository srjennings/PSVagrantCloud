Function Find-VagrantCloudBox {
<#
.SYNOPSIS
Search for Vagrant Cloud Boxes 
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will search and find Vagrant Cloud boxes utilizing a variety of arguments

.PARAMETER q
The search query. Results will match the username, name, or short_description fields for a box. If omitted, the top boxes based on sort and order will be returned (defaults to "downloads desc").

.PARAMETER provider
Filter results to boxes supporting for a specific provider.

.PARAMETER sort
The field to sort results on. Can be one of "downloads", "created", or "updated". Defaults to "downloads".

.PARAMETER order
The order to return the sorted field in. Can be "desc" os "asc". Defaults to "desc".

.PARAMETER limit
The number of results to return (max of 100). Defaults to "100".

.PARAMETER page
Specify pages. Defaults to "1".

.INPUTS
none

.OUTPUTS
System.Management.Automation.PSCustomObject

.EXAMPLE
Find-VagrantCloudBox
Run a wildcard query.


.EXAMPLE
Find-VagrantCloudBox -q hashicorp | select -ExpandProperty name
Query a specific username, and list the boxes. In this example, username is 'hashicorp'. Since the object returns the 'name' object in collapsed form, we need to expand the property to list it.

.EXAMPLE
Find-VagrantCloudBox -q hashicorp -provider vmware

Query the 'hashicorp' username for all boxes that use the 'vmware' provider.

.EXAMPLE
Find-VagrantCloudBox -q hashicorp -provider aws | select name,createddate,updateddate

Query the 'hashicorp' username for all boxes that use the 'aws' provider and list the name, createddate and updateddate fields.

.NOTES
Author: Steven Jennings <steven@automatingops.com>

Github: https://github.com/deyjcode/PSVagrantCloud
#>
    [CmdletBinding()]
    param(
        [string]$q,
        [string]$provider,
        [ValidateSet("downloads", "created", "updated")]
        [string]$sort = "downloads",
        [ValidateSet("desc", "asc")]
        [string]$order = "desc",
        [int]$limit = "100",
        [int]$page = '1'
    )

    $TokenName = "VAGRANT_CLOUD_TOKEN"
    try {
        $GrabToken = Get-Item "Env:\$TokenName" -ErrorAction SilentlyContinue
        Write-Verbose "API Token already exists."
        $VagrantCloudToken = $GrabToken.value
    }
    catch {
        Write-Host "We need to create a Vagrant Cloud Token..."
        Invoke-VagrantCloudLocalToken
        $GrabToken = Get-Item "Env:\$TokenName" -ErrorAction SilentlyContinue
        $VagrantCloudToken = $GrabToken.value
    }

    if ($q -and $provider -and $sort -and $order -and $limit -and $page) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?q=$q&provider=$provider&sort=$sort&order=$order&limit=$limit&page=$page"
    } 
    
    elseif ($q -and $provider -and $sort -and $order -and $limit) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?q=$q&provider=$provider&sort=$sort&order=$order&limit=$limit"
    }

    elseif ($q -and $provider -and $sort -and $order) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?q=$q&provider=$provider&sort=$sort&order=$order"
    }

    elseif ($q -and $provider -and $sort) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?q=$q&provider=$provider&sort=$sort"
    }

    elseif ($q -and $provider) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?q=$q&provider=$provider"
    }

    elseif ($q -is [string]) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?q=$q"
    }

    elseif ($provider -is [string]) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?provider=$provider"
    }

    elseif ($sort -is [string]) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?sort=$sort"
    }

    elseif ($order -is [string]) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?order=$order"
    }

    elseif ($limit -is [string]) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?limit=$limit"
    }

    elseif ($page -is [string]) {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?page=$page"
    }

    else {
        $VagrantAPIURI = "https://app.vagrantup.com/api/v1/search?"
    }

    $VagrantAPIMethod = "GET"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    try {
        $FindBoxes = Invoke-RestMethod -Uri $VagrantAPIURI -Headers $VagrantCloudHeaders -Method $VagrantAPIMethod -ContentType "application/json"
        $FoundBoxObject = [PSCustomObject]@{
            Tag = $FindBoxes.boxes.tag
            Username = $FindBoxes.boxes.username
            Name = $FindBoxes.boxes.name
            Private = $FindBoxes.boxes.Private
            Downloads = $FindBoxes.boxes.downloads
            CreatedDate = $FindBoxes.boxes.created_at
            UpdatedDate = $FindBoxes.boxes.updated_at
            ShortDescription = $FindBoxes.boxes.short_description
            DescriptionMarkdown = $FindBoxes.boxes.description_markdown
            DescriptionHTML = $Findboxes.boxes.description_html
            CurrentVersion = $FindBoxes.boxes.current_version
        }
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }

    return $FoundBoxObject
}
