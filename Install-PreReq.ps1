# set ipv4 options
$ipaddress = "10.10.10.254"
$ipprefix = "24"
$ipgw = "10.10.10.2"
$ipdns = "8.8.8.8"
$ipif = (Get-NetAdapter).ifIndex 
New-NetIPAddress -IPAddress $ipaddress -PrefixLength $ipprefix -InterfaceIndex $ipif -DefaultGateway $ipgw

# disable ipv6, 'cause ain't no one got time for dat shit
Get-NetAdapterBinding -ComponentID 'ms_tcpip6' | Disable-NetAdapterBinding -ComponentID ms_tcpip6

# set hostname
Rename-Computer -NewName "OVERMIND" 

# install features 
$featureLogPath = "c:\poshlog\featurelog.txt" 
New-Item $featureLogPath -ItemType file -Force 
$addsTools = "RSAT-AD-Tools" 
Add-WindowsFeature $addsTools 
Get-WindowsFeature | Where installed >>$featureLogPath

Restart-Computer
