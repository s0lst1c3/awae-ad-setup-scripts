# define scope and DHCP options
$DNSDomain="example.com"
$DNSServerIP="10.10.10.254"
$DHCPServerIP="10.10.10.254"
$StartRange="10.10.10.100"
$EndRange="10.10.10.199"
$Subnet="255.255.255.0"
$Router="10.10.10.4"
 
# mojo 
Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools
cmd.exe /c "netsh dhcp add securitygroups"
Restart-service dhcpserver
Add-DhcpServerInDC -DnsName $Env:COMPUTERNAME
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2
Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange $StartRange -EndRange $EndRange -SubnetMask $Subnet
Set-DhcpServerV4OptionValue -DnsDomain $DNSDomain -DnsServer $DNSServerIP -Router $Router 
Set-DhcpServerv4Scope -ScopeId $DHCPServerIP -LeaseDuration 1.00:00:00
