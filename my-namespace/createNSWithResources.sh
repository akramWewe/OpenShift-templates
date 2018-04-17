namsespace_name=$1
#DEV, TEST, PREPROD, PROD
environnement=$2
#PACST,PACSV
site=$3
#default,DMZ,LAN
zone=$4
#The sum of CPU requests across all pods in a non-terminal state cannot exceed this value
requests_cpu=$5
#The sum of memory requests across all pods in a non-terminal state cannot exceed this value. 
requests_memory=$6
#The sum of storage requests across all persistent volume claims in any state cannot exceed this value.
requests_storage=$7
#The sum of CPU limits across all pods in a non-terminal state cannot exceed this value.
limits_cpu=$8
#The sum of memory limits across all pods in a non-terminal state cannot exceed this value.
limits_memory=$9
# Across all persistent volume claims in a project, the sum of storage requested in the gold storage class cannot exceed this value.
gold_requests_storage='$10'
# Across all persistent volume claims in a project, the sum of storage requested in the silver storage class cannot exceed this value.
silver_requests_storage='$11'
# Across all persistent volume claims in a project, the sum of storage requested in the bronze storage class cannot exceed this value.
bronze_requests_storage='$12'

#Exemple: ./createNS.sh test PACST default
./createNS.sh ${namsespace_name} ${site} ${zone}

#Exemple ./initiNS.sh test 1 1Gi 50Gi 2 2Gi 10Gi 20Gi 0
./initiNS.sh \
$namsespace_name \
$requests_cpu \
$requests_memory \
$requests_storage \
$limits_cpu \
$limits_memory \
$gold_requests_storage \
$silver_requests_storage \
$bronze_requests_storage