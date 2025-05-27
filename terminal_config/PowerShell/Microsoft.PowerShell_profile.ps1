# ===============================
# PowerShell 7 Minimal Profile
# Optimized for speed + dev work
# ===============================

# Simple prompt - fast & clean
function prompt {
    "PS $PWD> "
}

# Tab shows a menu of completion options
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Prediction from history only (fast, no plugin)
Set-PSReadLineOption -PredictionSource History

# Show inline gray text suggestion (non-intrusive)
Set-PSReadLineOption -PredictionViewStyle InlineView

# Optional: Faster history saving (adjust as you want)
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -HistoryNoDuplicates

# Avoid loading heavy modules or prompts here
# Load them manually only if you need them in a session

# End of profile


# ~/.config/powershell/Microsoft.PowerShell_profile.ps1

Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression

Set-PSReadLineOption -BellStyle None