<#
	Semi automatic setup script for gaming rig.
	Tasks:
	1. Log into Battle.net when it finishes installing to allow games to install.
#>
$Boxstarter.AutoLogin = $true
$Boxstarter.NoPassword = $false
$Boxstarter.RebootOk = $true

$installNvidiaDriver = $true;

$chocoApps = @(
	"chocolateygui", 
	"lastpass",
	"intel-dsa",
	"intel-graphics-driver",
	"office365homepremium",
	"speccy",
	"microsoft-edge-insider",
	"googlechrome",
	"firefox",
	"notepadplusplus",
	"large-text-file-viewer",
	"winmerge",
	"kdiff3",
	"filezilla",
	"vscode",
	"azure-data-studio",
	"chocolatey-vscode.extension",
	"netfx-4.5.2-devpack",
	"netfx-4.6.2-devpack",
	"netfx-4.7.2-devpack",
	"dotnetfx",
	"nodejs-lt",
	"webpi",
	"nuget.commandline",
	"7zip",
	"hxd",

	"visualstudio2019-workload-nativecrossplat",
	"visualstudio2019-workload-netcrossplat",
	"visualstudio2019-workload-netweb",
	"visualstudio2019-workload-azure",
	"visualstudio2019-workload-nativedesktop",
	"visualstudio2019-workload-visualstudioextension",
	"visualstudio2019-workload-node"
);

$windowsfeatures = @(
	"Microsoft-Hyper-V-All",
	"IIS-CGI"
	"IIS-ManagementConsole"
	"IIS-ISAPIExtensions"
	"IIS-ISAPIFilter"
	"IIS-DefaultDocument"
	"IIS-DirectoryBrowsing"
	"IIS-StaticContent"
	"IIS-RequestFiltering"
	"IIS-HttpErrors"
	"IIS-HttpRedirect"
);

$vscodeExtensions = @(
	"schneiderpat.aspnet-helper",
	"ms-vscode.cpptools",
	"ms-vscode.csharp",
	"ms-azuretools.vscode-docker",
	"ms-edgedevtools.vscode-edge-devtools",
	"sterin.msbuild-tools",
	"ms-vscode.powershell",
	"dotjoshjohnson.xml",
	"imanolea.z80-asm"
);

$vs2019Extensions = @(
	@{
		Name = "ResXManager"
		Url = "https://tomenglert.gallerycdn.vsassets.io/extensions/tomenglert/resxmanager/1.36.2407/1560090997516/ResXManager.VSIX.vsix"
		Checksum = "73bc5b9ed9defe091466f61cf94593f66d7c6ecc"
		ChecksumType = "sha1"
	}
	@{
		Name = "MDK-SE"
		Url = "https://github.com/malware-dev/MDK-SE/releases/download/1.2.22/MDK.vsix"
		Checksum = "41bc0960be5cd25e2a9778d6e088b0c034fd6cc70bcd159a3da1691132d6c081"
		ChecksumType = "sha256"
	}
);

$customApps = @(

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
);

$tempDir = "$env:TEMP\chocolatey"

foreach ($feature in $windowsFeatures) {
	cinst $feature --source windowsFeatures --cacheLocation "$tempDir"
}

if (Test-PendingReboot) { Invoke-Reboot }

if ($installNvidiaDriver) {
	choco feature enable -n=useRememberedArgumentsForUpgrades
	cinst nvidia-display-driver --package-parameters="'/dch'" --cacheLocation "$tempDir"
	if (Test-PendingReboot) { Invoke-Reboot }
}

foreach ($app in $chocoApps) {
	cinst $app --cacheLocation "$tempDir"
}

foreach ($app in $customApps) {
	Choco-InstallPackage @app
}

if (Test-PendingReboot) { Invoke-Reboot }

Update-SessionEnvironment
Import-Module $Env:ChocolateyInstall\helpers\chocolateyInstaller.psm1
Import-Module $Env:ChocolateyInstall\extensions\chocolatey-vscode\*.psm1

foreach ($extension in $vscodeExtensions) {
	Install-VsCodeExtension $extension
}

foreach ($extension in $vs2019Extensions) {	
	Install-ChocolateyVsixPackage -PackageName $extension.Name -VsixUrl $extension.Url -Checksum $extension.Checksum -ChecksumType $extension.ChecksumType
}

# Remove Windows Apps
foreach ($app in $junkApps) {
	Write-Output "Trying to remove $app"

	Get-AppxPackage $app -AllUsers | Remove-AppxPackage -AllUsers

	Get-AppXProvisionedPackage -Online |
		Where-Object DisplayName -EQ $app |
		Remove-AppxProvisionedPackage -Online
}

if (Test-PendingReboot) { Invoke-Reboot }