function Create-Channel
{   
   param (   
             $ChannelName,$GroupId
         )   
    Process
    {
        try
            {
                $teamchannels = $ChannelName -split ";" 
                if($teamchannels)
                {
                    for($i =0; $i -le ($teamchannels.count - 1) ; $i++)
                    {
                        New-TeamChannel -GroupId $GroupId -DisplayName $teamchannels[$i]
                    }
                }
            }
        Catch
            {
            }
    }
}

function Add-Users
{   
    param(   
             $Users,$GroupId,$CurrentUsername,$Role
          )   
    Process
    {
        
        try{
                $teamusers = $Users -split ";" 
                if($teamusers)
                {
                    for($j =0; $j -le ($teamusers.count - 1) ; $j++)
                    {
                        if($teamusers[$j] -ne $CurrentUsername)
                        {
                            Add-TeamUser -GroupId $GroupId -User $teamusers[$j] -Role $Role
                        }
                    }
                }
            }
        Catch
            {
            }
        }
}

function Create-NewTeam
{   
   param (   
             $ImportPath
         )   
  Process
    {
       
        $teams = Import-Csv -Path $ImportPath
        foreach($team in $teams)
        {
            $getteam= get-team |where-object { $_.displayname -eq $team.TeamsName}
            If($getteam -eq $null)
            {
                Write-Host "Start creating the team: " $team.TeamsName
                $group = New-Team -DisplayName $team.TeamsName  -Visibility $team.TeamType
                Write-Host "Creating channels..."
                Create-Channel -ChannelName $team.ChannelName -GroupId $group.GroupId
                Write-Host "Adding team members..."
                Add-Users -Users $team.Members -GroupId $group.GroupId -CurrentUsername $username  -Role Member 
                Write-Host "Adding team owners..."
                Add-Users -Users $team.Owners -GroupId $group.GroupId -CurrentUsername $username  -Role Owner
                Write-Host "Completed creating the team: " $team.TeamsName
                $team=$null
            }
         }
    }
}

Create-NewTeam -ImportPath "C:\Temp\TeamsData.csv"





-MailNickName $team.TeamsName 
#TeamsName, TeamType, ChannelName, Owners, Members