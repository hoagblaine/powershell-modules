# PowerShell Modules

Custom PowerShell modules for productivity and workflow automation.

## Modules

### MyToolKit

General-purpose IT toolkit for system management and daily use.

| Command | Alias | Description |
|---------|-------|-------------|
| `Get-SystemBrief` | `info` | Quick system health summary |
| `Invoke-QuickCleanup` | `qc` | Clears temp files |
| `gitsearch` | `gs` | Search GitHub (`gs "query" repositories`) |
| `Start-App` | `sa` | Launch any installed app with tab-completion |
| `Find-Path` | `fp` | Recursive file search across drives |
| `Get-DetailedList` | `ll` | Linux-style `ls -la` with file sizes |
| `Get-Weather` | `weather` | Current weather from wttr.in (default to location based on ip address|

### SearchTools

Launch searches from the terminal — just type the engine name and your query.

| Command | Alias | Description |
|---------|-------|-------------|
| `Search-Google` | `google` | `google "powershell modules"` |
| `Search-YouTube` | `youtube`, `yt` | `youtube "linux tutorial"` |
| `Search-Claude` | `claude` | `claude "help me write a script"` |
| `Search-ChatGPT` | `gpt` | `gpt "explain kubernetes"` |
| `Search-Reddit` | `reddit` | `reddit "arch linux hyprland"` |
| `Search-StackOverflow` | `so` | `so "powershell hashtable"` |
| `Search-Wikipedia` | `wiki` | `wiki "mesh networking"` |

## Installation

1. Clone the repo:
   ```powershell
   git clone https://github.com/hoagblaine/powershell-modules.git
   ```

2. Copy modules to your PowerShell modules directory:
   ```powershell
   Copy-Item MyToolKit.psm1 "$HOME\Documents\WindowsPowerShell\Modules\MyToolKit\MyToolKit.psm1"
   Copy-Item SearchTools.psm1 "$HOME\Documents\WindowsPowerShell\Modules\SearchTools\SearchTools.psm1"
   ```

3. If your modules folder is in OneDrive, unblock the files:
   ```powershell
   Get-ChildItem "$HOME\OneDrive\Documents\WindowsPowerShell\Modules" -Recurse -Filter *.psm1 | Unblock-File
   ```

4. Add to your PowerShell profile:
   ```powershell
   Import-Module MyToolKit
   Import-Module SearchTools
   ```
