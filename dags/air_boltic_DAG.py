from airflow import DAG
from airflow.providers.docker.operators.docker import DockerOperator
from datetime import datetime

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 9, 1),
    'retries': 1,
}

with DAG('air_boltic_DAG', default_args=default_args, schedule_interval='@daily') as dag:
    run_dbt = DockerOperator(
        task_id='run_dbt',
        image='ghcr.io/dbt-labs/dbt-bigquery:1.5.0',
        api_version='auto',
        auto_remove=True,
        command='bash',
        docker_url='unix://var/run/docker.sock',
        network_mode='bridge',
        volumes=[
            '/opt/airflow/dbt_project:/usr/app/dbt',  # DBT project directory
            '/opt/airflow/dbt_profiles:/root/.dbt'    # Profiles directory
        ]
    )
