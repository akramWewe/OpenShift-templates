# Au niveau du projet Default, retrouver le STATS_PASSWORD du routeur
oc set env dc router -n default --list|grep STATS_PASSWORD|awk -F"=" '{print $2}'

# Positionner le mot de passe du routeur. 

oc new-project prometheus
oc create -f template/prometheus.yaml
oc new-app -f template/prometheus.yaml --param ROUTER_PASSWORD=<Router Password>


#APPLICATION DEMO
oc new-project demoapplication
oc new-app -f https://raw.githubusercontent.com/ConSol/springboot-monitoring-example/master/templates/restservice_template.yaml -n demoapplication

#Prometheus
oc new-project prometheus
oc new-app -f prometheus/template/prometheus.yaml -p NAMESPACE=prometheus

#Graphana
oc new-project grafana
oc new-app -f grafana/tmplate/grafana.yaml -p NAMESPACE=grafana
oc policy add-role-to-user view system:serviceaccount:grafana:grafana-ocp -n prometheus

oc adm pod-network join-projects --to=grafana prometheus