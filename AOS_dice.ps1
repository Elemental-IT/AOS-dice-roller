# Author Theo bird

# Change the variables to modify the dice outputs 
# Crit Rolls are Mortal wounds for the time being I will add order wounds when I give this UI

# Edit these for Numders for role values
## If there are no critical hits leave the value of $Crit as zero  
$Attacks      = 61
$Crit         = 5 
$Hit          = 2
$Wound        = 3
$Save         = 4
$Rend         = 0
$Damage       = 1

# leave these values 
$Attackrolls  = 1..$Attacks
$CritRolls    = $null
$HitRolls     = $null
$WoundRolls   = $null
$SaveRolls    = $null 
$DamageTotal  = $null
$HitRollsArr  = @()
$WoundRollArr = @()

function D6 {Get-Random -Minimum 1 -Maximum 7}
function D3 {Get-Random -Minimum 1 -Maximum 3}

 
$Attackrolls   | ForEach-Object { $HitRoll = D6 ; $HitRollsArr += $HitRoll ; if($HitRoll -ge $Crit){$DamageTotal += $Damage;$CritRolls++}Else{if(($HitRoll -ge $Hit) -and ($HitRoll -lt $Crit)){$HitRolls++}}}
1..$HitRolls   | ForEach-Object { $WoundRoll = D6 ; $WoundRollArr += $WoundRoll ; if($WoundRoll -ge $Wound){$WoundRolls++}}
1..$WoundRolls | ForEach-Object { $SaveRoll = D6 ; if($SaveRoll -ge ($save - $Rend)){$SaveRolls++}}
$DamageTotal += $SaveRolls * $Damage 


Write-Host "Crit hits $CritRolls"
Write-Host "hits $HitRolls"
Write-Host "Wounds $WoundRolls"
Write-Host "fail Saves $SaveRolls"
Write-Host "Total Damage $DamageTotal"
Write-Host $null

Write-Host "Hit rolls"
$HitRollsArr = $HitRollsArr | Group-Object | Sort-Object Name | ForEach-Object {
    [PSCustomObject]@{
        Name  = $_.Name
        Count = $_.Count
    }
}

$HitRollsArr | ft


Write-Host "Wound rolls"
$WoundRollArr = $WoundRollArr | Group-Object | Sort-Object Name | ForEach-Object {
    [PSCustomObject]@{
        Name  = $_.Name
        Count = $_.Count
    }
}


$WoundRollArr | ft
