###### Installation consul dans OCP #########
oc create sa consulsa
oc adm policy add-scc-to-user anyuid consulsa
oc adm policy add-scc-to-user privileged consulsa
oc adm policy add-scc-to-group anyuid system:authenticated
oc adm policy add-scc-to-user anyuid system:serviceaccount:consul:consulsa

GOSSIP_ENCRYPTION_KEY=$(consul keygen)

#Creatio,n des secrets
GOSSIP_ENCRYPTION_KEY=$(consul keygen)
oc create secret generic consul \
  --from-literal="gossip-encryption-key=${GOSSIP_ENCRYPTION_KEY}" \
  --from-file=secrets/ca.pem \
  --from-file=secrets/consul.pem \
  --from-file=secrets/consul-key.pem

# Creation de la configMap
oc create configmap consul --from-file=configmap/server.json

# Creation des services
oc create -f services/consul-1.yaml
oc create -f services/consul-2.yaml
oc create -f services/consul-3.yaml

# Creation de l'image stream
oc create -f is/consul.yaml

# Pas nécessaire pour le moment
# Creatation des pvs
# oc create -f pv/pv_consul_1
# oc create -f pv/pv_consul_2
# oc create -f pv/pv_consul_3

# Creation d'une route
oc create -f /root/openshift-templates/consul/src/routes/route.json


# Creation des dcs 
oc create -f deployments/consul-1.yaml
oc create -f deployments/consul-2.yaml
oc create -f deployments/consul-3.yaml

# Pas nécessaire car les dc portes déja les sa
# oc patch dc/consul-1 --patch '{"spec":{"template":{"spec":{"serviceAccountName": "consulsa"}}}}'
# oc patch dc/consul-2 --patch '{"spec":{"template":{"spec":{"serviceAccountName": "consulsa"}}}}'
# oc patch dc/consul-3 --patch '{"spec":{"template":{"spec":{"serviceAccountName": "consulsa"}}}}'


# Creation via template
oc create -f  template/consul-template.json
oc new-app consul-ocp -p =Y 
# Creation d'une route
oc create -f /root/openshift-templates/consul/src/routes/route.json


# Creation des dcs 
oc create -f deployments/consul-1.yaml
oc create -f deployments/consul-2.yaml
oc create -f deployments/consul-3.yaml

# Pas nécessaire car les dc portes déja les sa
# oc patch dc/consul-1 --patch '{"spec":{"template":{"spec":{"serviceAccountName": "consulsa"}}}}'
# oc patch dc/consul-2 --patch '{"spec":{"template":{"spec":{"serviceAccountName": "consulsa"}}}}'
# oc patch dc/consul-3 --patch '{"spec":{"template":{"spec":{"serviceAccountName": "consulsa"}}}}'


# Creation via template
oc create -f  template/consul-template.json
oc new-app consul-ocp -p =Y 


###### Rajout d'un service d'une application Demo dans consul #########
oc create configmap app.d --from-file=app.json

# Rajout des services de monitoring des applications à Consul (déja present dans les DC)
# oc set volume dc/consul-1 --add --name=conf-service --mount-path=/etc/consul.d --configmap-name=app.d --overwrite
# oc set volume dc/consul-2 --add --name=conf-service --mount-path=/etc/consul.d --configmap-name=app.d --overwrite
# oc set volume dc/consul-3 --add --name=conf-service --mount-path=/etc/consul.d --configmap-name=app.d --overwrite

# Redeployer les DCs
oc rollout latest consul-1
oc rollout latest consul-2
oc rollout latest consul-3