<#
	Semi automatic setup script for gaming rig.
	Tasks:
	1. Log into Battle.net when it finishes installing to allow games to install.
#>

$chocoApps = @(
	"chocolateygui", 
	"lastpass",
	"steam",
	"battle.net",
	"twitch",
	"discord",
	"geforce-experience",
	"office365homepremium",
	"googlechrome",
	"minecraft"
);

$bnetApps = @(
	 "WoW" # World of Warcraft
);

$junkApps = @(
	"Microsoft.BingFinance"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingTranslator"
	"Microsoft.BingWeather"

	"Microsoft.MicrosoftOfficeHub"
	"Microsoft.MicrosoftSolitaireCollection"
	"Microsoft.MinecraftUWP"
	"Microsoft.Wallet"
	"microsoft.windowscommunicationsapps"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"

	"Microsoft.CommsPhone"
	"Microsoft.ConnectivityStore"
	"Microsoft.GetHelp"
	"Microsoft.Getstarted"
	"Microsoft.Messaging"
	"Microsoft.Office.Sway"

	"Microsoft.MixedReality.Portal"

	"Microsoft.BingFoodAndDrink"
	"Microsoft.BingHealthAndFitness"
	"Microsoft.BingTravel"
	"Microsoft.WindowsReadingList"

	"2FE3CB00.PicsArt-PhotoStudio"
	"46928bounde.EclipseManager"
	"613EBCEA.PolarrPhotoEditorAcademicEdition"
	"6Wunderkinder.Wunderlist"
	"7EE7776C.LinkedInforWindows"
	"89006A2E.AutodeskSketchBook"
	"9E2F88E3.Twitter"
	"A278AB0D.DisneyMagicKingdoms"
	"A278AB0D.MarchofEmpires"
	"ActiproSoftwareLLC.562882FEEB491"
	"CAF9E577.Plex"  
	"ClearChannelRadioDigital.iHeartRadio"
	"D52A8D61.FarmVille2CountryEscape"
	"D5EA27B7.Duolingo-LearnLanguagesforFree"
	"DB6EA5DB.CyberLinkMediaSuiteEssentials"
	"DolbyLaboratories.DolbyAccess"
	"DolbyLaboratories.DolbyAccess"
	"Drawboard.DrawboardPDF"
	"Facebook.Facebook"
	"Fitbit.FitbitCoach"
	"Flipboard.Flipboard"
	"GAMELOFTSA.Asphalt8Airborne"
	"KeeperSecurityInc.Keeper"
	"Microsoft.BingNews"
	"NORDCURRENT.COOKINGFEVER"
	"PandoraMediaInc.29680B314EFC2"
	"Playtika.CaesarsSlotsFreeCasino"
	"ShazamEntertainmentLtd.Shazam"
	"TheNewYorkTimes.NYTCrossword"
	"ThumbmunkeysLtd.PhototasticCollage"
	"TuneIn.TuneInRadio"
	"WinZipComputing.WinZipUniversal"
	"XINGAG.XING"
	"flaregamesGmbH.RoyalRevolt2"
	"king.com.*"
);

$tempDir = "$env:TEMP\chocolatey"
choco feature enable -n=useRememberedArgumentsForUpgrades
cinst geforce-game-ready-driver --package-parameters="'/dch'" --cacheLocation "$tempDir"

foreach ($app in $chocoApps) {
	cinst $app --cacheLocation "$tempDir"
}

foreach ($app in $bnetApps) {
	Battle.net.exe --game=$app
}

# Remove Windows Apps
foreach ($app in $junkApps) {
	Write-Output "Trying to remove $app"

	Get-AppxPackage $app -AllUsers | Remove-AppxPackage -AllUsers

	Get-AppXProvisionedPackage -Online |
		Where-Object DisplayName -EQ $app |
		Remove-AppxProvisionedPackage -Online
}
