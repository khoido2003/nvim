# Minimal PowerShell 7 Profile for WezTerm, Neovim, and Game Dev
function prompt {
    "PS $PWD> "
}

# PSReadLine for fast completions
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -MaximumHistoryCount 1000
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\hul10.omp.json" | Invoke-Expression
# Measure-Command { oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\hul10.omp.json" | Invoke-Expression }

# Heavy module
function s {
    carapace _carapace | Out-String | Invoke-Expression
}

