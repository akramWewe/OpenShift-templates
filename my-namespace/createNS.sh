namsespace_name=$1
label_name=$2

oc project default

echo "Creation du namespace $namespace_name"
oc process -f my-namespace.yaml -p name_namespace=$namsespace_name -p label=$label_name -n default | oc create -f -




