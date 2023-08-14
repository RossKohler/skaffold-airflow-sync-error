## Steps to Reproduce Sync Error ##
1. Git clone repository
2. Run `kind create cluster --config=kind-config.yaml`
3. Run `kubectl create namespace airflow`
4. Run `skaffold dev --port-forward`
5. Observe the following error message repeatedly shown whenever changes are made to `.py` files in the `dags/test_folder` folder. Editing `.py` files directly in the `dags` folder, sync correctly:
```
WARN[0138] Skipping deploy due to sync error:copying files: running [kubectl --context kind-airflow-sync-error-cluster exec airflow-webserver-86649d6786-xkb6k --namespace airflow -c webserver -i -- tar xmf - -C / --no-same-owner]
 - stdout: ""
 - stderr: "tar: Removing leading `/' from member names\ntar: opt/airflow/dags/test_folder/test_dag_1.py: Cannot open: File exists\ntar: Exiting with failure status due to previous errors\ncommand terminated with exit code 2\n"
 - cause: exit status 2: sync failed for artifact "airflow-skaffold:1e848fa7f2a293361600329f269d2829fe3ca8c58267195ead78bb8d50de216e"  subtask=-1 task=DevLoop
Watching for changes...
```
