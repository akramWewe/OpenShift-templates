namsespace_name=$1
environnement=$2
site=$3
zone=$4

oc project default

echo "Creation du namespace $namespace_name"
oc project default
oc process -f my-namespace.yaml -p name_namespace=$namsespace_name \
-p environnement=$environnement \
-p site=$site \
-p zone=$zone \
-n default | oc create -f -




