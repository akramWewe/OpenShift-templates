namespace_name=$1
requests_cpu=$2
requests_memory=$3
requests_storage=$4
limits_cpu=$5
limits_memory=$6
gold_requests_storage=$7
silver_requests_storage=$8
bronze_requests_storage=$9

echo "Initialiser les resources au namespace $namsespace_name"

oc project $namespace_name

oc process -f namespace-resources-template.yaml \
-p requests_cpu=$requests_cpu \
-p requests_memory=$requests_memory \
-p requests_storage=$requests_storage \
-p limits_cpu=$limits_cpu \
-p limits_memory=$limits_memory \
-p gold_requests_storage=$gold_requests_storage \
-p silver_requests_storage=$silver_requests_storage \
-p bronze_requests_storage=$bronze_requests_storage \
-n $namespace_name | oc create -f -
