namsespace_name=$1
echo "1- Creation du namespace $namespace_name"
oc new-project $namsespace_name

echo "2- Creation du la resource quotas"
oc project $namsespace_name
oc create -f my-quotas.yaml -n $namsespace_name
oc process my-quotas -n $namsespace_name | oc create -f -


