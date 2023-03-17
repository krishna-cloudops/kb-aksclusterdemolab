$rgName = "kb-akshandsonlab"
$locationName = "eastus"
$aksClusterName = "kb-akscluser"
$acrName = "kb-akscr"
$sqlSrvName = "kb-sqlsrv"
$uname = "sqladmin"
$pword = 'P2ssw0rd1234'
$sqldbName = "mhcdb"



$version=$(az aks get-versions -l $locationName --query 'orchestrators[-1].orchestratorVersion')

az group create --name $rgName --location $locationName
az aks create --resource-group $rgName --name $aksClusterName --kubernetes-version $version --generate-ssh-keys --location $locationName
az acr create --resource-group $rgName --name $acrName --sku Standard --location $locationName
az aks update -n $aksClusterName  -g $rgName --attach-acr $acrName
az sql server create -l $locationName -g $rgName -n $sqlSrvName -u $uname -p $pword
az sql db create -g $rgName -s $sqlSrvName -n $sqldbName --service-objective S0