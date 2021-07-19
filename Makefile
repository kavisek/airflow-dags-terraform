

list:
	# List containers
	gcloud container clusters list 

credentials:
	gcloud container clusters get-credentials airflow-cluster --zone us-central1-a


# Deployment Command

repo:
	helm repo add apache-airflow https://airflow.apache.org

rm_namespace:
	kubectl delete namespace airflow

create_namespace:
	kubectl create namespace airflow
	helm install airflow apache-airflow/airflow \
	--namespace airflow \
	--set webserver.livenessProbe.initialDelaySeconds=30

operations:
	watch -n 30 gcloud container operations list

extract:
	kubectl get deployment.apps/airflow-webserver -n airflow -o yaml > ./chart/airflow-webserver.yaml
	kubectl get deployment.apps/airflow-flower -n airflow -o yaml > ./chart/airflow-flower.yaml
	kubectl get deployment.apps/airflow-scheduler -n airflow -o yaml > ./chart/airflow-scheduler.yaml
	kubectl get deployment.apps/airflow-statsd -n airflow -o yaml > ./chart/airflow-statsd.yaml

watch:
	# Refresh this view every 10 seconds.
	watch -n 30 kubectl get namespace,deployment,svc,po -A

forward:
	# Port forward the gcloud.
	gcloud container clusters get-credentials airflow-cluster --zone us-central1-a --project kavi-prod-airflow-dags \
 	&& kubectl port-forward --namespace airflow $(kubectl get pod --namespace airflow --selector="component=webserver,release=airflow,tier=airflow" --output jsonpath='{.items[0].metadata.name}') 8080:8080
