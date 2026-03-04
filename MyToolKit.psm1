<#
.SYNOPSIS
    Permanent IT Toolkit Module.
#>

# --- PRIVATE HELPER FUNCTIONS ---
# These are used by your other scripts but won't show up in your terminal.
function _Log-Activity {
    param($Message)
    Write-Host "[LOG]: $Message" -ForegroundColor Gray
}

# --- Tools ---

function Get-SystemBrief {
    <#
    .SYNOPSIS
        Displays a quick summary of system health.
    #>
    _Log-Activity "Gathering system info..."
    Get-ComputerInfo | Select-Object WindowsVersion, OsArchitecture, CsName
}

function Invoke-QuickCleanup {
    <#
    .SYNOPSIS
        Clears temp files and empties trash.
    #>
    _Log-Activity "Starting cleanup..."
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Cleanup Complete!" -ForegroundColor Green
}

function gitsearch {
	<#
	.SYNOPSIS
		search GITHUB
	#>
	param($q, $type)
	start "https://github.com/search?q=$($q -replace ' ', '+')&type=$type"
}

function Start-App {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
            # This only runs when you hit TAB
            (Get-StartApps).Name | Where-Object { $_ -like "$wordToComplete*" -and $_ -notmatch "http://|nvidia" }
        })]
        [string]$AppName
    )

    process {
        $App = Get-StartApps | Where-Object { $_.Name -eq $AppName }
        if ($App) {
            Write-Host "Launching $($App.Name)..." -ForegroundColor Green
            Start-Process "explorer.exe" -ArgumentList "shell:appsFolder\$($App.AppID)"
        } else {
            Write-Warning "App '$AppName' not found."
        }
    }
}

function Find-Path {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name,
        
        [string]$Path = "C:\"
    )
    # -Filter is faster than 'Where-Object' for large drives
    Get-ChildItem -Path $Path -Filter "*$Name*" -Recurse -ErrorAction SilentlyContinue | 
        Select-Object -ExpandProperty FullName
}

function Get-DetailedList {
    <#
    .SYNOPSIS
        A 'Linux-style' long list that shows hidden files and sizes.
    #>
    Get-ChildItem -Force | Select-Object LastWriteTime, Mode, @{Name="Size(MB)";Expression={"{0:N2}" -f ($_.Length / 1MB)}}, Name
}

function Get-Weather {
    [CmdletBinding()]
    param(
        [string]$Location = ""
    )

    try {
        $Weather = (Invoke-WebRequest "http://wttr.in/${Location}?format=j1" -UserAgent "curl" -UseBasicParsing).Content | ConvertFrom-Json
        $Current = $Weather.current_condition

        [PSCustomObject]@{
            Temperature  = "$($Current.temp_F)$([char]0x00B0)F"
            Precipitation = "$($Current.precipMM)mm"
            Humidity     = "$($Current.humidity)%"
            Pressure     = "$($Current.pressure)mb"
            WindSpeed    = "$($Current.windspeedMiles)mph"
            WindDirection = $Current.winddir16Point
            UVIndex      = $Current.uvIndex
            Visibility   = "$($Current.visibility)km"
            CloudCover   = "$($Current.cloudcover)%"
            Description  = $Current.weatherDesc.value
            Area         = $Weather.nearest_area.areaName.value
            Region       = $Weather.nearest_area.region.value
        }
    }
    catch {
        Write-Error "Failed to fetch weather: $_"
    }
}

# --- Aliases ---
Set-Alias -Name weather -Value Get-Weather
Set-Alias -Name gs -Value gitsearch
Set-Alias -Name sa -Value Start-App
Set-Alias -Name fp -Value Find-Path
Set-Alias -Name btop -Value btop4win
Set-Alias -Name ll -Value Get-DetailedList
Set-Alias -Name qc -Value Invoke-QuickCleanup
Set-Alias -Name info -Value Get-SystemBrief

# --- Exporting Functions and Aliases ---
Export-ModuleMember -Function Get-SystemBrief, Invoke-QuickCleanup, Find-Path, Start-App, gitsearch, Get-DetailedList, Get-Weather -Alias sa, gs, fp, ll, qc, info, btop, weather


