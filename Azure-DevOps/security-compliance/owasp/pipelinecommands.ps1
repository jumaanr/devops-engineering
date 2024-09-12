#1. Azure CLI - Storage account

az storage account create -g template-grp -n owaspstore222000 -l northeurope --sku Standard_LRS
az storage share create -n security --account-name owaspstore222000

#2. Azure CLI - Container Instance
az storage account keys list -g template-grp --account-name owaspstore222000 --query "[0].value" --output tsv > temp.txt
$content = Get-Content temp.txt -First 1
$key = '"{0}"' -f $content
Write-Output $key
 
echo "https://newapp787878.azurewebsites.net"> url.txt
$url = Get-Content url.txt -First 1
$completeurl = '"{0}"' -f $url

$ZAP_COMMAND="zap-baseline.py -t $completeurl -x OWASP-ZAP-Report.xml -r testreport.html"

az container create -g template-grp -n owasp --image owasp/zap2docker-stable --ip-address public --ports 8080 --azure-file-volume-account-name owaspstore222000 --azure-file-volume-account-key $key --azure-file-volume-share-name security --azure-file-volume-mount-path "/zap/wrk" --command-line $ZAP_COMMAND --restart-policy Never

#3. Azure CLI - Download Report

Start-Sleep -Seconds 30

az storage account keys list -g template-grp --account-name owaspstore222000 --query "[0].value" --output tsv > temp.txt
$content = Get-Content temp.txt -First 1
$key = '"{0}"' -f $content

az storage file download --account-name owaspstore222000 --account-key $key -s security -p OWASP-ZAP-Report.xml --dest %SYSTEM_DEFAULTWORKINGDIRECTORY%\OWASP-ZAP-Report.xml

#4. PowerShell Script - Convert Report

$XslPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)\_sqlapp-connection\xslt-artifact\OWASPToNUnit3.xslt"
$XmlInputPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)\OWASP-ZAP-Report.xml"
$XmlOutputPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)\Converted-OWASP-ZAP-Report.xml"
$XslTransform = New-Object System.Xml.Xsl.XslCompiledTransform
$XslTransform.Load($XslPath)
$XslTransform.Transform($XmlInputPath, $XmlOutputPath)