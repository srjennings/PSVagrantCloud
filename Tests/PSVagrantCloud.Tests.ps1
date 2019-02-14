$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

$scripts = Get-ChildItem $projectRoot -Include *.ps1,*.psm1,*.psd1 -Recurse

Describe "General project validation: $moduleName" {

    # TestCases are splatted to the script so we need hashtables
    $testCase = $scripts | Foreach-Object{@{file=$_}}
    It "Script <file> should be valid powershell" -TestCases $testCase {
        param($file)

        $file.fullname | Should Exist

        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should Be 0
    }

    It "Module '$moduleName' can import cleanly" {
        {Import-Module (Join-Path $moduleRoot "$moduleName.psm1") -force } | Should Not Throw
    }
}

Describe "PSScriptAnalyzer for module: $Script:ModuleName" {
    $rules = Get-ScriptAnalyzerRule -Severity Error

    foreach ($file in $scripts) {
        Context "Script '$($file.FullName)'" {
            $results = Invoke-ScriptAnalyzer -Path $file.FullName -IncludeRule $rules
            if ($results) {
                foreach ($rule in $results) {
                    It $rule.RuleName {
                        $message = "{0} Line {1}: {2}" -f $rule.Severity, $rule.Line, $rule.message
                        $message | Should -Be ""
                    }
                }
            }
            else {
                It "PSScriptAnalyzer Results PASSED" {
                    $results | Should -BeNullOrEmpty
                }
            }
        }
    }
}