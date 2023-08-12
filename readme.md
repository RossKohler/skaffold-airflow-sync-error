## Steps to Reproduce Sync Error ##
1. Git clone repository
2. Run `kind create cluster --config=kind-config.yaml`
3. Run `kubectl create namespace airflow`
4. Run `skaffold dev --port-forward`
5. Observe the following error message repeatedly shown whenever changes are made to `.py` files in the `dags` folder:
```
WARN[0192] sync failed for artifact "airflow:560e03907dcbd22f46c6fbbe4f5a5d2b38b8137edcbe8e964b98fa42bcff5d35"  subtask=-1 task=DevLoop
WARN[0192] Skipping deploy due to sync error:copying files: didn't sync any files: sync failed for artifact "airflow:560e03907dcbd22f46c6fbbe4f5a5d2b38b8137edcbe8e964b98fa42bcff5d35"  subtask=-1 task=DevLoop
Watching for changes...
```

## Note ##
Syncing works correctly when using the community chart found here https://github.com/airflow-helm/charts. See https://artifacthub.io/packages/helm/airflow-helm/airflow.

I followed this article to get it working https://christoph-caprano.de/kubernetes-airflow-local-development-setup/. The same procedure doesn't work for the official Airflow helm chart for some reason.

## Steps to Sync with Airflow Deployment (Deployed through Community Chart) ##

1. Git clone repository
2. Run `kind create cluster --config=kind-config.yaml`
3. Run `kubectl create namespace airflow` 
4. Run `helm install airflow helm/airflow-stable/ -f helm/airflow-stable/values.yaml --values helm/airflow-stable/values.local.yaml --namespace airflow` -> This step is added because when the pods initialy start up some of them error which makes Skaffold panic and immediately abort everything. Give it some time and the pods will stabilize.
4. Run `skaffold dev -f skaffold-community.yaml --port-forward`

Observe that the `xcom_args_are_awesome` DAG is now listed in the home page and any changes to the Python code is correctly sync to the deployment. This works as I would expect it to. If only I could get the same thing working with the official Airflow helm chart.