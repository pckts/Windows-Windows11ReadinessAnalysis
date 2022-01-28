$Resultdump = "\\SHARE\PATH\ClientData.csv" #FX \\DC\W11Readiness\ClientData.csv

$ProgressPreference = "SilentlyContinue"
#WinVer - quits if pc is not win 10
$WinVer = (get-computerinfo | select-object WindowsProductName).WindowsProductName
if ($WinVer -notmatch "Windows 10")
{
    exit
}

#CPU
$CPUCount = (Get-ComputerInfo -Property "CsNumberOfLogicalProcessors").CsNumberOfLogicalProcessors
$CPUSpeed = Get-CimInstance Win32_Processor | Select-Object -Expand MaxClockSpeed
$CPUModel = (Get-ComputerInfo -Property "CsProcessors").CsProcessors.Name
if ($CPUCount -ge 2 -and $CPUSpeed -ge 1000)
{
    $CPUCompat = $true
    $SupportedCPUs=@("x6200FE","x6211E","x6212RE","x6413E","x6414RE","x6425E","x6427FE","G4900","G4900T","G4920","G4930","G4930E","G4930T","G4932E","G4950","J4005","J4105","J4115","N4000","N4100","3867U","4205U","4305U","4305UE","J4025","J4125","N4020","N4120","5205U","5305U","G5900","G5900E","G5900T","G5900TE","G5905","G5905T","G5920","G5925","J6412","J6413","N6210","N6211","N4500","N4505","N5100","N5105","6305","6305E","i5-10210Y","i5-10310Y","i5-8200Y","i5-8210Y","i5-8310Y","i7-10510Y","i7-8500Y","m3-8100Y","i3-8100","i3-8100B","i3-8100H","i3-8100T","i3-8109U","i3-8140U","i3-8300","i3-8300T","i3-8350K","i5-8400","i5-8500","i5-8257U","i5-8259U","i5-8260U","i5-8269U","i5-8279U","i5-8300H","i5-8400","i5-8400B","i5-8400H","i5-8400T","i5-8500","i5-8500B","i5-8500T","i5-8600","i5-8600K","i5-8600T","i7-8086K","i7-8557U","i7-8559U","i7-8569U","i7-8700","i7-8700B","i7-8700K","i7-8700T","i7-8750H","i7-8850H","i3-8130U","i5-8250U","i5-8350U","i7-8550U","i7-8650U","i3-8145U","i3-8145UE","i5-8265U","i5-8365U","i5-8365UE","i7-8565U","i7-8665U","i7-8665UE","i3-9100","i3-9100E","i3-9100F","i3-9100HL","i3-9100T","i3-9100TE","i3-9300","i3-9300T","i3-9320","i3-9350K","i3-9350KF","i5-9300H","i5-9300HF","i5-9400","i5-9400F","i5-9400H","i5-9400T","i5-9500","i5-9500E","i5-9500F","i5-9500T","i5-9500TE","i5-9600","i5-9600K","i5-9600KF","i5-9600T","i7-9700","i7-9700E","i7-9700F","i7-9700K","i7-9700KF","i7-9700T","i7-9700TE","i7-9750H","i7-9750HF","i7-9850H","i7-9850HE","i7-9850HL","i9-8950HK","i9-9880H","i9-9900","i9-9900K","i9-9900KF","i9-9900KS","i9-9900T","i9-9980HK","i3-10100Y","i3-10110Y","i9-10900X","i9-10920X","i9-10940X","i9-10980XE","i3-10100","i3-10100E","i3-10100F","i3-10100T","i3-10100TE","i3-10105","i3-10105F","i3-10105T","i3-10110U","i3-10300","i3-10300T","i3-10305","i3-10305T","i3-10320","i3-10325","i5-10200H","i5-10210U","i5-10300H","i5-10310U","i5-10400","i5-10400F","i5-10400H","i5-10400T","i5-10500","i5-10500E","i5-10500H","i5-10500T","i5-10500TE","i5-10600","i5-10600K","i5-10600KF","i5-10600T","i7-10510U","i7-10610U","i7-10700","i7-10700E","i7-10700F","i7-10700K","i7-10700KF","i7-10700T","i7-10700TE","i7-10710U","i7-10750H","i7-10810U","i7-10850H","i7-10870H","i7-10875H","i9-10850K","i9-10885H","i9-10900","i9-10900E","i9-10900F","i9-10900K","i9-10900KF","i9-10900T","i9-10900TE","i9-10980HK","i3-1000G1","i3-1000G4","i3-1005G1","i5-1030G4","i5-1030G7","i5-1035G1","i5-1035G4","i5-1035G7","i5-1038NG7","i7-1060G7","i7-1065G7","i7-1068NG7","i3-L13G4","i5-L16G7","i5-11400","i5-11400F","i5-11400T","i5-11500","i5-11500T","i5-11600","i5-11600K","i5-11600KF","i5-11600T","i7-11700","i7-11700F","i7-11700K","i7-11700KF","i7-11700T","i9-11900","i9-11900F","i9-11900K","i9-11900KF","i9-11900T","i3-1110G4","i3-1115G4","i3-1115G4E","i3-1115GRE","i3-1120G4","i3-1125G4","i5-11300H","i5-1130G7","i5-1135G7","i5-1135G7","i5-1140G7","i5-1145G7","i5-1145G7E","i5-1145GRE","i7-11370H","i7-11375H","i7-1160G7","i7-1165G7","i7-1165G7","i7-1180G7","i7-1185G7","i7-1185G7E","i7-1185GRE","4425Y","6500Y","G5400","G5400T","G5420","G5420T","G5500","G5500T","G5600","G5600T","G5620","4425Y","6500Y","G5400","G5400T","G5420","G5420T","G5500","G5500T","G5600","G5600T","G5620","J5005","N5000","4417U","5405U","4417U","5405U","J5040","N5030","6405U","G6400","G6400E","G6400T","G6400TE","G6405","G6405T","G6500","G6500T","G6505","G6505T","G6600","G6605","6405U","G6400","G6400E","G6400T","G6400TE","G6405","G6405T","G6500","G6500T","G6505","G6505T","G6600","G6605","6805","J6426","N6415","N6000","N6005","7505","3104","3106","5115","5118","5119T","5120","5120T","5122","6126","6126F","6126T","6128","6130","6130F","6130T","6132","6134","6136","6138","6138F","6138P","6138T","6140","6142","6142F","6144","6146","6148","6148F","6150","6152","6154","8153","8156","8158","8160","8160F","8160T","8164","8168","8170","8176","8176F","8180","4108","4109T","4110","4112","4114","4114T","4116","4116T","E-2124","E-2124G","E-2126G","E-2134","E-2136","E-2144G","E-2146G","E-2174G","E-2176G","E-2176M","E-2186G","E-2186M","E-2224","E-2224G","E-2226G","E-2226GE","E-2234","E-2236","E-2244G","E-2246G","E-2254ME","E-2254ML","E-2274G","E-2276G","E-2276M","E-2276ME","E-2276ML","E-2278G","E-2278GE","E-2278GEL","E-2286G","E-2286M","E-2288G","3204","3206R","5215","5215L","5217","5218B","5218N","5218R","5218T","5220","5220R","5220S","5220T","5222","6208U","6209U","6210U","6212U","6222V","6226","6226R","6230","6230N","6230R","6230T","6238","6238L","6238T","6240","6240L","6240R","6240Y","6242","6242R","6244","6246R","6248","6248R","6250","6250L","6252","6252N","6254","6256","6258R","6262V","5218","6238R","6246","6234","8253","8256","8260","8260L","8260Y","8268","8270","8276","8276L","8280","8280L","9221","9222","9242","9282","4208","4209T","4210","4210R","4210T","4214","4214R","4214Y","4215","4215R","4216","W-2223","W-2225","W-2235","W-2245","W-2255","W-2265","W-2275","W-2295","W-3223","W-3225","W-3235","W-3245","W-3245M","W-3265","W-3265M","W-3275","W-3275M","W-10855M","W-10885M","W-1250","W-1250E","W-1250P","W-1250TE","W-1270","W-1270E","W-1270P","W-1270TE","W-1290","W-1290E","W-1290P","W-1290T","W-1290TE","5315Y","5317","5318N","5318S","5320","5320T","6312U","6314U","6326","6330","6330N","6334","6336Y","6338","6338N","6338T","6342","6346","6348","6354","5318Y","8351N","8352S","8352V","8352Y","8358","8358P","8360Y","8368","8368Q","8380","4309Y","4310","4310T","4314","4316","3015e","3020e","3150C","3150U","3050C","3050e","3050U","3000G","300GE","300U","320GE","3150G","3150GE","3050GE","7232P","7252","7262","7272","7282","7302","7302P","7352","7402","7402P","7452","7502","7502P","7532","7542","7552","7642","7662","7702","7702P","7742","7F32","7F52","7F72","7H12","72F3","7313","7313P","7343","73F3","7413","7443","7443P","7453","74F3","7513","7543","7543P","75F3","7643","7663","7713","7713P","7763","3250C","3250U","3200G","3200GE","3200U","3350U","2300X","5300U","3100","3300U","4300G","4300GE","4300U","5400U","3200G","3200GE","3300U","4350G","4350GE","4450U","5450U","3400G","3400GE","3450U","3500C","3500U","3550H","3580U","2500X","2600","2600E","2600X","5500U","3500","3600","3600X","3600XT","4600G","4500U","4600GE","4600H","4600U","5600H","5600HS","5600U","5600X","3400G","3400GE","3500U","2600","3600","4650G","4650GE","4650U","5650U","3700C","3700U","3750H","3780U","2700","2700E","2700X","5700U","3700X","3800X","3800XT","4700G","4700GE","4700U","4800H","4800HS","4800U","5800H","5800HS","5800U","5800","5800X","3700U","2700","2700X","4750G","4750GE","4750U","5850U","3900","3900X","3900XT","3950X","4900H","4900HS","5900HS","5900HX","5980HS","5980HX","5900","5900X","5950X","3900","2920X","2950X","2970WX","2990WX","3960X","3970X","3990X","3945WX","3955WX","3975WX","3995WX")
    $CPUSupported = $null
    foreach ($SupportedCPU in $SupportedCPUs)
    {
        if ($CPUModel -match $SupportedCPU)
        {
            $CPUSupported = $true
        }
    }
}
else
{
    $CPUCompat = $false
}
$CPUScore = New-Object -TypeName PSObject
if ($CPUCompat -eq $true -and $CPUSupported -eq $true)
{
    $CPUScore | Add-Member -NotePropertyName Score -NotePropertyValue "1" -Force
}
elseif ($CPUCompat -eq $true -and $CPUSupported -ne $true)
{
    $CPUScore | Add-Member -NotePropertyName Score -NotePropertyValue "0" -Force
}
elseif ($CPUCompat -ne $true)
{
    $CPUScore | Add-Member -NotePropertyName Score -NotePropertyValue "0" -Force
}

#RAM
$RAMCount = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum
$RAMScore = New-Object -TypeName PSObject
if ($RAMCount -gt 4000000000)
{
    $RAMScore | Add-Member -NotePropertyName Score -NotePropertyValue "1" -Force
}
else
{
    $RAMScore | Add-Member -NotePropertyName Score -NotePropertyValue "0" -Force
}

#Disk
$DiskFree = (Get-CimInstance -ClassName Win32_LogicalDisk | select-object FreeSpace).freespace
$DiskScore = New-Object -TypeName PSObject
if ($DiskFree -ge 70000000000)
{
    $DiskScore | Add-Member -NotePropertyName Score -NotePropertyValue "1" -Force
}
else
{
    $DiskScore | Add-Member -NotePropertyName Score -NotePropertyValue "0" -Force
}

#UEFI
$BIOSType = (get-computerinfo -property "BiosFirmwareType").BiosFirmwareType
$UEFIScore = New-Object -TypeName PSObject
if ($BIOSType -eq "uefi")
{
    $UEFIScore | Add-Member -NotePropertyName Score -NotePropertyValue "1" -Force
}
else
{
    $UEFIScore | Add-Member -NotePropertyName Score -NotePropertyValue "0" -Force
}

#SECUREBOOT
$SecureBootState = Confirm-SecureBootUEFI
$SBScore = New-Object -TypeName PSObject
if ($SecureBootState -eq "true")
{
    $SBScore | Add-Member -NotePropertyName Score -NotePropertyValue "1" -Force
}
else
{
    $SBScore | Add-Member -NotePropertyName Score -NotePropertyValue "0" -Force
}

#TPM
$TPMState = (get-tpm | select-object Tpmpresent).tpmpresent
$TPMVersion = (get-tpm | select-object ManufacturerVersionFull20).ManufacturerVersionFull20
$TPMScore = New-Object -TypeName PSObject
if ($TPMState -eq "true" -and $TPMVersion -ne $null)
{
    $TPMScore | Add-Member -NotePropertyName Score -NotePropertyValue "1" -Force
}
else
{
    $TPMScore | Add-Member -NotePropertyName Score -NotePropertyValue "0" -Force
}


#####
$hostname = New-Object -TypeName PSObject
$username = New-Object -TypeName PSObject
$FINALScore = New-Object -TypeName PSObject
$hostname | Add-Member -NotePropertyName Score -NotePropertyValue "$env:COMPUTERNAME" -Force
$username | Add-Member -NotePropertyName Score -NotePropertyValue "$env:USERNAME" -Force

if ($CPUScore.score -eq "0" -or $RAMScore.score -eq "0" -or $DiskScore.score -eq "0" -or $UEFIScore.score -eq "0" -or $SBScore.score -eq "0" -or $TPMScore.score -eq "0" )
{
    $FINALScore | Add-Member -NotePropertyName Score -NotePropertyValue "0" -Force
}

if ($CPUScore.score -eq "1" -and $RAMScore.score -eq "1" -and $DiskScore.score -eq "1" -and $UEFIScore.score -eq "1" -and $SBScore.score -eq "1" -and $TPMScore.score -eq "1" )
{
    $FINALScore | Add-Member -NotePropertyName Score -NotePropertyValue "1" -Force
}


$Collection = New-Object PSObject -Property @{

Hostname = $hostname.score
CPUScore = $CPUScore.score
RAMScore = $RAMScore.score
DiskScore = $DiskScore.score
UEFIScore = $UEFIScore.score
SBScore = $SBScore.score
TPMScore = $TPMScore.score
FINALScore = $FINALScore.score

}
$Collection | Select Hostname, CPUScore, RAMScore, DiskScore, UEFIScore, SBScore, TPMScore, FINALScore | export-csv $ResultDump -NoTypeInformation -Encoding Unicode -Append