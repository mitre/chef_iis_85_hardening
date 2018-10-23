#
# Cookbook:: .
# Recipe:: services_and_features
#
# Copyright:: 2018, The Authors, All Rights Reserved.

powershell_script 'Initial Setup' do
  code <<-EOH
  Install-WindowsFeature -Name Web-Scripting-Tools
  Install-WindowsFeature -Name Web-Mgmt-Service
  Install-WindowsFeature -Name Web-Http-Redirect
  Install-WindowsFeature -Name Web-Custom-Logging
  Install-WindowsFeature -Name Web-Log-Libraries
  Install-WindowsFeature -Name Web-ODBC-Logging
  Install-WindowsFeature -Name Web-Request-Monitor
  Install-WindowsFeature -Name Web-Http-Tracing
  Install-WindowsFeature -Name Web-Dyn-Compression
  Install-WindowsFeature -Name Web-Basic-Auth
  Install-WindowsFeature -Name Web-CertProvider
  Install-WindowsFeature -Name Web-Client-Auth
  Install-WindowsFeature -Name Web-Digest-Auth
  Install-WindowsFeature -Name Web-Cert-Auth
  Install-WindowsFeature -Name Web-IP-Security
  Install-WindowsFeature -Name Web-Net-Ext45
  Install-WindowsFeature -Name Web-Asp-Net45
  Install-WindowsFeature -Name Web-ISAPI-Ext
  Install-WindowsFeature -Name Web-ISAPI-Filter
  EOH
end

powershell_script 'V-76771' do
  code <<-EOH
  Install-WindowsFeature -Name Web-Url-Auth
  Set-WebConfigurationProperty -filter "system.webServer/security/authentication/anonymousAuthentication" -name enabled -value false -PSPath "MACHINE/WEBROOT/APPHOST"
  Set-WebConfigurationProperty -filter "system.webServer/security/authentication/basicAuthentication" -name enabled -value true -PSPath "MACHINE/WEBROOT/APPHOST"
  Set-WebConfigurationProperty -filter "system.webServer/security/authentication/basicAuthentication" -name defaultLogonDomain -value Administrator -PSPath "MACHINE/WEBROOT/APPHOST"
  EOH
end

powershell_script 'V-76769' do
  code <<-EOH
  Install-WindowsFeature -Name Web-ISAPI-Ext
  Set-WebConfigurationProperty -filter "system.webServer/security/isapiCgiRestriction" -name notListedCgisAllowed -value false -PSPath "MACHINE/WEBROOT/APPHOST"
  Set-WebConfigurationProperty -filter "system.webServer/security/isapiCgiRestriction" -name notListedIsapisAllowed -value false -PSPath "MACHINE/WEBROOT/APPHOST"
  EOH
end

powershell_script 'V-76757' do
  code <<-EOH
  Set-WebConfigurationProperty -filter "system.webServer/asp/session" -name keepSessionIdSecure -value true -PSPath "MACHINE/WEBROOT/APPHOST"
  EOH
end

powershell_script 'V-76753' do
  code <<-EOH
  Uninstall-WindowsFeature -Name Print-Services
  EOH
end

powershell_script 'V-76747' do
  code <<-EOH
  Set-WebConfigurationProperty -filter "system.ApplicationHost/log/centralW3CLogFile" -name directory -value #{node['iis']['logDirectory']} -PSPath "MACHINE/WEBROOT/APPHOST"
  Set-WebConfigurationProperty -filter "system.ApplicationHost/log/centralW3CLogFile" -name period -value Daily -PSPath "MACHINE/WEBROOT/APPHOST"
  EOH
end

powershell_script 'V-76737' do
  code <<-EOH
  Set-WebConfigurationProperty -filter "system.webServer/httpErrors" -name errorMode -value 0 -PSPath "MACHINE/WEBROOT/APPHOST"
  EOH
end

powershell_script 'V-76733' do
  code <<-EOH
  Set-WebConfigurationProperty -filter "system.webServer/directoryBrowse" -name enabled -value False -PSPath "MACHINE/WEBROOT/APPHOST"
  EOH
end

powershell_script 'V-76731' do
  code <<-EOH
  Set-WebConfigurationProperty -filter "system.web/machineKey" -PSPath "MACHINE/WEBROOT/APPHOST" -name decryption -value Auto
  Set-WebConfigurationProperty -filter "system.web/machineKey" -PSPath "MACHINE/WEBROOT/APPHOST" -name validation -value #{node['iis']['validation']}
  EOH
end

powershell_script 'V-76727, V-76725' do
  code <<-EOH
  Set-WebConfigurationProperty -filter "system.web/sessionState" -name cookieless -value UseCookies -PSPath "MACHINE/WEBROOT/APPHOST"
  Set-WebConfigurationProperty -filter "system.web/sessionState" -name timeout -value #{node['iis']['sessionStateTimeout']} -PSPath "MACHINE/WEBROOT/APPHOST"
  EOH
end

powershell_script 'V-76713' do
  code <<-EOH
  Uninstall-WindowsFeature -Name Web-DAV-Publishing
  EOH
end