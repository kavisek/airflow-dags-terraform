

list:
	# List containers
	gcloud container clusters list 

credentials:
	gcloud container clusters get-credentials airflow-cluster --zone us-central1-a


# Deployment Command

craete_namespace:
	kubectl create namespace airflow

deploy:
	helm repo add apache-airflow https://airflow.apache.org
	helm install airflow apache-airflow/airflow --namespace airflow

watch:
	# Refresh this view every 10 seconds.
	watch -n 10 kubectl get po,svc,deployment -A