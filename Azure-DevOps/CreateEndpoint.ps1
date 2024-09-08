$TrafficManagerProfileName="deploymentprofile"
$ResourceGroupName ="template-grp"
$TargetResourceId="/subscriptions/6912d7a0-bc28-459a-9407-33bbba641c07/resourceGroups/template-grp/providers/Microsoft.Web/sites/deploymentapp1000-staging"
$TargetEndPoint="deploymentapp1000-staging.azurewebsites.net"



$TrafficManagerEndpoint = New-AzTrafficManagerEndpoint -Name "staging" `
-ProfileName $TrafficManagerProfileName -Type AzureEndpoints `
-TargetResourceId $TargetResourceId -EndpointStatus Enabled `
-Weight 100 -ResourceGroupName $ResourceGroupName 

Add-AzTrafficManagerCustomHeaderToEndpoint -TrafficManagerEndpoint $TrafficManagerEndpoint -Name "host" -Value $TargetEndPoint
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $TrafficManagerEndpoint
