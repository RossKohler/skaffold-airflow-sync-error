FROM apache/airflow:2.7.0rc1-python3.10

USER root
COPY dags dags
