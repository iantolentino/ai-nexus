$root = Split-Path -Parent $PSScriptRoot
$tools = Get-ChildItem "$root/_brain/tools" -Filter '*.ps1' -File
foreach ($tool in $tools) { [scriptblock]::Create((Get-Content $tool.FullName -Raw)) | Out-Null }
& powershell -NoProfile -ExecutionPolicy Bypass -File "$root/_brain/tools/select-context.ps1" -Intent framework-maintenance -NoManifest | Out-Null
& powershell -NoProfile -ExecutionPolicy Bypass -File "$root/_brain/tools/brain-doctor.ps1" | Out-Null
if ($LASTEXITCODE -ne 0) { throw 'Brain Doctor smoke test failed.' }
Write-Output "PASS: $($tools.Count) tool scripts parsed; selector and Brain Doctor ran."
