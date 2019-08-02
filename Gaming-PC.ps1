$chocoApps = @(
	"chocolateygui", 
	"lastpass",
	"steam",
	"battle.net",
	"origin",
	"twitch",
	"discord",
	"playnite",
	"intel-dsa",
	"intel-graphics-driver",
	"geforce-game-ready-driver",
	"geforce-experience",
	"office365homepremium",
	"speccy",
	"7zip"
);

$steamApps = @(
	 244850 # Space Engineers
	,493340 # Planet Coaster
	,289070 # Civilization VI
	,255710 # Cities: Skylines
	,464920 # Surviving Mars
	,242820 # Banished
	,333950 # Medieval Engineers
	,323190 # Frostpunk
	,223850 # 3DMark
	,535950 # Two Point Hospital
);

$bnetApps = @(
	 "WoW" # World of Warcraft
	,"Pro" # Overwatch
)

$customApps = @(
	# Edge Chromium Dev Channel
	@{
		packageName		= 'microsoft-edge-chromium'
		url				= 'https://c2rsetup.officeapps.live.com/c2r/downloadEdge.aspx?ProductreleaseID=Edge&platform=Default&version=Edge&Channel=Dev&language=en&Consent=1&IID=024e931a-e3f6-5629-89cd-ca135e4f1b02'
		softwareName	= 'Microsoft Edge Dev'
		checksum		= '0793e3586febe8ecd3b44bfd9fd701676785628a3210e26f81fadbd2a42607b9'
		checksumType	= 'sha256'
		silentArgs		= '--mode unattended'
		validExitCodes	= @(0, 3010, 1641)
	}
)

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
	"4DF9E0F8.Netflix"
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
)

foreach ($app in $chocoApps) {
	cinst $app
}

foreach ($app in $steamApps) {
	steam.exe "steam://install/$app"
}

foreach ($app in $bnetApps) {
	Battle.net.exe --game=$app
}

foreach ($app in $customApps) {
	Choco-InstallPackage @app
}

# Remove Windows Apps
foreach ($app in $junkApps) {
	Write-Output "Trying to remove $app"

	Get-AppxPackage $app -AllUsers | Remove-AppxPackage -AllUsers

	Get-AppXProvisionedPackage -Online |
		Where-Object DisplayName -EQ $app |
		Remove-AppxProvisionedPackage -Online
}
