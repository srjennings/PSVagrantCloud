# PSVagrantCloud 
PSVagrantCloud provides a way to interface with the Vagrant Cloud api through PowerShell.

### Prerequisites to get started
* A Vagrant Cloud Account
    * Create one here: https://app.vagrantup.com/account/new
* Supported Editions of PowerShell: 
    * Windows
    * Core

The PowerShell Module can be used to generate API tokens, used for the majority of commands and tasks!

## Installation
At a PowerShell command prompt, run:
```powershell
Install-Module PSVagrantCloud
```

This will download the module from the official source, **PSGallery**.

## Alternate Installation
1. Pull down the module directly from git (clone):
```bash
git clone https://github.com/deyjcode/PSVagrantCloud.git
```
2. Copy the folder into a `PSModulePath` environment variable location.

3. Import the module with `Import-Module`

## Issues with Installation
Error: `Package 'PSVagrantCloud' failed to be installed because: End of Central Directory
record could not be found.`
This issue occurs because of a hash mismatch from PSGallery. This is a known issue from [PSGallery](https://github.com/PowerShell/PowerShellGallery/blob/master/psgallery_status.md#10242018---some-downloads-failing-with-end-of-central-directory-record-could-not-be-found).

Use the **Alternate Installation** above as a workaround.

### Documentation
All module documentation can be found in the built-in help. As well, in this repository, one can find markdown generated help from PlatyPS to quickly find what you are looking for.

### Use Case
Use this module to find, create, update all types of objects from the Vagrant Cloud.

### Help needed or questions?
Feel free to open an issue or contribute!

### To-Do
* Add functionality to [upload new providers](https://www.vagrantup.com/docs/vagrant-cloud/api.html#update-a-provider). In the interest of time, and lack of personal need, this functionality is not yet added.
* Format errors a bit better.
* Incorporate more uses of the pipeline
