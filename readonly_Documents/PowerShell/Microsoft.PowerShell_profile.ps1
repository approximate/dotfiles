<#
.SYNOPSIS
    Microsoft.PowerShell_profile.ps1 - My PowerShell profile
.DESCRIPTION
    Microsoft.PowerShell_profile - Customizes the PowerShell console
.NOTES
    File Name   : Microsoft.PowerShell_profile.ps1
    Author      : Konstantin Zverev (konstantin.zverev@traxpay.com)
#>

# Set-Location C:\Users\konstantin.zverev\dotfiles\PowerShell

# Not useful -- can be replaced by `time` command
# function Get-Time { return $(Get-Date | ForEach-Object { $_.ToLongTimeString() }) }

#function ll {
#    param ($dir = ".", $all = $false)
#
#    $origFg = $Host.UI.RawUI.ForegroundColor
#    if ( $all ) { $toList = Get-ChildItem -force $dir }
#    else { $toList = Get-ChildItem $dir }
#
#    foreach ($Item in $toList) {
#        Switch ($Item.Extension) {
#            ".exe" { $Host.UI.RawUI.ForegroundColor = "DarkYellow" }
#            ".hta" { $Host.UI.RawUI.ForegroundColor = "DarkYellow" }
#            ".cmd" { $Host.UI.RawUI.ForegroundColor = "DarkRed" }
#            ".ps1" { $Host.UI.RawUI.ForegroundColor = "DarkGreen" }
#            ".html" { $Host.UI.RawUI.ForegroundColor = "Cyan" }
#            ".htm" { $Host.UI.RawUI.ForegroundColor = "Cyan" }
#            ".7z" { $Host.UI.RawUI.ForegroundColor = "Magenta" }
#            ".zip" { $Host.UI.RawUI.ForegroundColor = "Magenta" }
#            ".gz" { $Host.UI.RawUI.ForegroundColor = "Magenta" }
#            ".rar" { $Host.UI.RawUI.ForegroundColor = "Magenta" }
#            Default { $Host.UI.RawUI.ForegroundColor = $origFg }
#        }
#        if ($item.Mode.StartsWith("d")) { $Host.UI.RawUI.ForegroundColor = "Gray" }
#        $item
#    }
#    $Host.UI.RawUI.ForegroundColor = $origFg
#}

function Edit-HostsFile {
    Start-Process -FilePath notepad -ArgumentList "$env:windir\system32\drivers\etc\hosts"
}

function rdp ($ip) {
    Start-Process -FilePath mstsc -ArgumentList "/admin /w:1024 /h:768 /v:$ip"
}

function tail ($file) {
    Get-Content $file -Wait
}

function whoami {
    [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
}

function Reset-Profile {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | ForEach-Object {
        if (Test-Path $_) {
            Write-Verbose "Running $_"
            . $_
        }
    }
}

function Get-SessionArch {
    if ([System.IntPtr]::Size -eq 8) { return "x64" }
    else { return "x86" }
}

function Test-Port {
    [cmdletbinding()]
    param(
        [parameter(mandatory = $true)]
        [string]$Target,
        [parameter(mandatory = $true)]
        [int32]$Port,
        [int32]$Timeout = 2000
    )
    $outputobj = New-Object -TypeName PSobject
    $outputobj | Add-Member -MemberType NoteProperty -Name TargetHostName -Value $Target
    if (Test-Connection -ComputerName $Target -Count 2) { $outputobj | Add-Member -MemberType NoteProperty -Name TargetHostStatus -Value "ONLINE" }
    else
    { $outputobj | Add-Member -MemberType NoteProperty -Name TargetHostStatus -Value "OFFLINE" }
    $outputobj | Add-Member -MemberType NoteProperty -Name PortNumber -Value $Port
    $Socket = New-Object System.Net.Sockets.TCPClient
    $Connection = $Socket.BeginConnect($Target, $Port, $null, $null)
    $Connection.AsyncWaitHandle.WaitOne($timeout, $false) | Out-Null
    if ($Socket.Connected -eq $true) { $outputobj | Add-Member -MemberType NoteProperty -Name ConnectionStatus -Value "Success" }
    else
    { $outputobj | Add-Member -MemberType NoteProperty -Name ConnectionStatus -Value "Failed" }
    $Socket.Close | Out-Null
    $outputobj | Select-Object TargetHostName, TargetHostStatus, PortNumber, Connectionstatus | Format-Table -AutoSize
}

Set-Alias grep select-string
Set-Alias im Import-Module

$MaximumHistoryCount = 1024
$IPAddress = @(Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object { $_.DefaultIpGateway })[0].IPAddress[0]
$PSVersion = $host | Select-Object -ExpandProperty Version
$PSVersion = $PSVersion -replace '^.+@\s'
$SessionArch = Get-SessionArch

# # Clear-Host
Write-Host "Host: $env:COMPUTERNAME ($IPAddress)"
Write-Host "User: $env:UserDomain\$env:UserName "
Write-Host "PoSH: $PSVersion ($SessionArch)"

# $LogicalDisk = @()
# Get-CimInstance Win32_LogicalDisk -filter "DriveType='3'" | ForEach-Object {
#     $LogicalDisk += @($_ | Select-Object @{n = "Name"; e = { $_.Caption } },
#         @{n = "Volume Label"; e = { $_.VolumeName } },
#         @{n = "Size (Gb)"; e = { "{0:N2}" -f ($_.Size / 1GB) } },
#         @{n = "Used (Gb)"; e = { "{0:N2}" -f (($_.Size / 1GB) - ($_.FreeSpace / 1GB)) } },
#         @{n = "Free (Gb)"; e = { "{0:N2}" -f ($_.FreeSpace / 1GB) } },
#         @{n = "Free (%)"; e = { if ($_.Size) { "{0:N2}" -f (($_.FreeSpace / 1GB) / ($_.Size / 1GB) * 100 ) } else { "NAN" } } })
# }
# $LogicalDisk | Format-Table -AutoSize | Out-String

# PSReadline
Import-Module PSReadline
Set-PSReadLineOption -EditMode Emacs

Import-Module posh-docker

$env:POSH_GIT_ENABLED = $true
Import-Module posh-git

$env:STARSHIP_CONFIG="C:\Users\konstantin.zverev\.config\starship.toml"
Invoke-Expression (&starship init powershell)

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Zoxide
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

# Better fzf integration
Import-Module PSFzf
# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

$env:FZF_DEFAULT_OPTS=@"
--layout=reverse
--cycle
--scroll-off=5
--border
--preview-window=right,60%,border-left
--bind ctrl-u:preview-half-page-up
--bind ctrl-d:preview-half-page-down
--bind ctrl-f:preview-page-down
--bind ctrl-b:preview-page-up
--bind ctrl-g:preview-top
--bind ctrl-h:preview-bottom
--bind alt-w:toggle-preview-wrap
--bind ctrl-e:toggle-preview
"@

function _fzf_open_path
{
  param (
    [Parameter(Mandatory=$true)]
    [string]$input_path
  )
  if ($input_path -match "^.*:\d+:.*$")
  {
    $input_path = ($input_path -split ":")[0]
  }
  if (-not (Test-Path $input_path))
  {
    return
  }
  $cmds = @{
    'bat' = { bat $input_path }
    'cat' = { Get-Content $input_path }
    'cd' = {
      if (Test-Path $input_path -PathType Leaf)
      {
        $input_path = Split-Path $input_path -Parent
      }
      Set-Location $input_path
    }
    'nvim' = { nvim $input_path }
    'remove' = { Remove-Item -Recurse -Force $input_path }
    'echo' = { Write-Output $input_path }
  }
  $cmd = $cmds.Keys | fzf --prompt 'Select command> '
  & $cmds[$cmd]
}

function _fzf_get_path_using_fd
{
  $input_path = fd --type file --follow --hidden --exclude .git |
    fzf --prompt 'Files> ' `
      --header-first `
      --header 'CTRL-S: Switch between Files/Directories' `
      --bind 'ctrl-s:transform:if not "%FZF_PROMPT%"=="Files> " (echo ^change-prompt^(Files^> ^)^+^reload^(fd --type file^)) else (echo ^change-prompt^(Directory^> ^)^+^reload^(fd --type directory^))' `
      --preview 'if "%FZF_PROMPT%"=="Files> " (bat --color=always {} --style=plain) else (eza -T --colour=always --icons=always {})'
  return $input_path
}

function _fzf_get_path_using_rg
{
  $INITIAL_QUERY = "${*:-}"
  $RG_PREFIX = "rg --column --line-number --no-heading --color=always --smart-case"
  $input_path = "" |
    fzf --ansi --disabled --query "$INITIAL_QUERY" `
      --bind "start:reload:$RG_PREFIX {q}" `
      --bind "change:reload:sleep 0.1 & $RG_PREFIX {q} || rem" `
      --bind 'ctrl-s:transform:if not "%FZF_PROMPT%" == "1. ripgrep> " (echo ^rebind^(change^)^+^change-prompt^(1. ripgrep^> ^)^+^disable-search^+^transform-query:echo ^{q^} ^> %TEMP%\rg-fzf-f ^& type %TEMP%\rg-fzf-r) else (echo ^unbind^(change^)^+^change-prompt^(2. fzf^> ^)^+^enable-search^+^transform-query:echo ^{q^} ^> %TEMP%\rg-fzf-r ^& type %TEMP%\rg-fzf-f)' `
      --color 'hl:-1:underline,hl+:-1:underline:reverse' `
      --delimiter ':' `
      --prompt '1. ripgrep> ' `
      --preview-label 'Preview' `
      --header 'CTRL-S: Switch between ripgrep/fzf' `
      --header-first `
      --preview 'bat --color=always {1} --highlight-line {2} --style=plain' `
      --preview-window 'up,60%,border-bottom,+{2}+3/3'
  return $input_path
}

function fdg
{
  _fzf_open_path $(_fzf_get_path_using_fd)
}

function rgg
{
  _fzf_open_path $(_fzf_get_path_using_rg)
}


# SET KEYBOARD SHORTCUTS TO CALL FUNCTION
Set-PSReadLineKeyHandler -Key "Ctrl+," ClearScreen

Set-PSReadLineKeyHandler -Key "Ctrl+f" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("fdg")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Key "Ctrl+g" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("rgg")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# More helper functions
function which ($command) { 
  Get-Command -Name $command -ErrorAction SilentlyContinue | 
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue 
}

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

# Better aliases for eza
function List-Dir-Normal {
    [alias('ls')]
    param([string]$Path = ".")
    eza.exe --group-directories-first --git --icons $Path
}

function List-Dir-All {
    [alias('la')]
    param([string]$Path = ".")
    eza.exe -lab --group-directories-first --git --icons $Path
}

function List-Dir-Long {
    [alias('ll')]
    param([string]$Path = ".")
    eza.exe -lb --group-directories-first --git --icons $Path
}

function List-Dir-New {
    [alias('lt')]
    param([string]$Path = ".")
    eza.exe -lab -snew --git --icons $Path
}

