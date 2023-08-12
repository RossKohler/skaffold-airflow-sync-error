FROM apache/airflow:2.5.3-python3.9

USER root
RUN apt-get update \
    && apt-get install -y gcc \
    && rm -rf /var/lib/apt/lists/*
USER airflow
COPY dags dags
