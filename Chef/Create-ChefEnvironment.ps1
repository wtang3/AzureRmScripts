## Azure Chef Deployment ##

## Define Variables ##

$azureProfile      = '.\credentials.txt'      # You can run Save-AzureRmProfile -Path "file location"
$location          = 'East US'                # You can run Get-AzureRmLocation | Where-Object Location -contains "your location name"
$resourceGroupName = 'ChefResourceGroup'      # Resource Group Name
$templateFile      = '.\azuredeploy.json'
$parameterFile     = '.\azuredeploy.parameters.json'

## Login ##

Select-AzureRmProfile -Profile $azureProfile

## Create Resource Group ##

New-AzureRmResourceGroup -Name $resourceGroupName -Location $location

## Test the deployment
$result = Test-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile -TemplateParameterFile $parameterFile

## If no errors Deploy
if($result.Count -eq 0){
    New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile -TemplateParameterFile $parameterFile
}else{
## Print out errors
    Write-Host "Errors occured."
    Write-Host $result
}