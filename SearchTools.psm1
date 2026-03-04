<#
.SYNOPSIS
    Quick-launch search module. Type a name, get results.
    Usage: google "query" | youtube "query" | claude "query"
#>

# --- Search Functions ---

function Search-Google {
    <#
    .SYNOPSIS
        Opens a Google search in your default browser.
    .EXAMPLE
        google "powershell modules"
    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Query
    )
    $encoded = [uri]::EscapeDataString($Query)
    Start-Process "https://www.google.com/search?q=$encoded"
}

function Search-YouTube {
    <#
    .SYNOPSIS
        Opens a YouTube search in your default browser.
    .EXAMPLE
        youtube "powershell tutorial"
    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Query
    )
    $encoded = [uri]::EscapeDataString($Query)
    Start-Process "https://www.youtube.com/results?search_query=$encoded"
}

function Search-Claude {
    <#
    .SYNOPSIS
        Opens Claude with your prompt pre-filled.
    .EXAMPLE
        claude "can you help me write a script"
    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Query
    )
    $encoded = [uri]::EscapeDataString($Query)
    Start-Process "https://claude.ai/new?q=$encoded"
}

function Search-ChatGPT {
    <#
    .SYNOPSIS
        Opens ChatGPT with a query.
    .EXAMPLE
        gpt "explain kubernetes pods"
    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Query
    )
    $encoded = [uri]::EscapeDataString($Query)
    Start-Process "https://chatgpt.com/?q=$encoded"
}

function Search-Reddit {
    <#
    .SYNOPSIS
        Searches Reddit in your default browser.
    .EXAMPLE
        reddit "arch linux hyprland"
    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Query
    )
    $encoded = [uri]::EscapeDataString($Query)
    Start-Process "https://www.reddit.com/search/?q=$encoded"
}

function Search-StackOverflow {
    <#
    .SYNOPSIS
        Searches Stack Overflow.
    .EXAMPLE
        stackoverflow "powershell hashtable"
        so "powershell hashtable"
    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Query
    )
    $encoded = [uri]::EscapeDataString($Query)
    Start-Process "https://stackoverflow.com/search?q=$encoded"
}

function Search-Wikipedia {
    <#
    .SYNOPSIS
        Searches Wikipedia.
    .EXAMPLE
        wiki "mesh networking"
    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Query
    )
    $encoded = [uri]::EscapeDataString($Query)
    Start-Process "https://en.wikipedia.org/w/index.php?search=$encoded"
}

# --- Aliases ---
Set-Alias -Name google   -Value Search-Google
Set-Alias -Name youtube  -Value Search-YouTube
Set-Alias -Name yt       -Value Search-YouTube
Set-Alias -Name claude   -Value Search-Claude
Set-Alias -Name gpt      -Value Search-ChatGPT
Set-Alias -Name reddit   -Value Search-Reddit
Set-Alias -Name so       -Value Search-StackOverflow
Set-Alias -Name wiki     -Value Search-Wikipedia

# --- Export ---
Export-ModuleMember -Function Search-Google, Search-YouTube, Search-Claude, Search-ChatGPT, Search-Reddit, Search-StackOverflow, Search-Wikipedia `
                    -Alias google, youtube, yt, claude, gpt, reddit, so, wiki
