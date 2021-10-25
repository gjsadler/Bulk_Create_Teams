Connect-MicrosoftTeams

$Teams = Import-csv D:\Teams.csv

Foreach ($team in $teams)

	$displayName = $DisplayName.Teams
	$description = $Description.Teams
	$mailNickName = $MailNickName.Teams
	$visibility = $Visibility.Teams

New-Team -DisplayName $displayName -Description $description -MailNickName $mailNickName -Visibility $visibility