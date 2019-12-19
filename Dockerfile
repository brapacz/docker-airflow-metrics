FROM puckel/docker-airflow

ENV AIRFLOW__CORE__LOAD_EXAMPLES true
ARG AIRFLOW_DEPS=datadog

COPY airflow.cfg.append /tmp/airflow.cfg.append
RUN cat /tmp/airflow.cfg.append >> /usr/local/airflow/airflow.cfg

USER root
COPY airflow-after-initdb.sh /tmp/airflow-after-initdb.sh
# indents lines in script
RUN sed -i 's/^/    /' /tmp/airflow-after-initdb.sh
RUN sed -i -e '/airflow initdb/r/tmp/airflow-after-initdb.sh' /entrypoint.sh

COPY requirements.txt /requirements.txt
COPY datadog_api_key.txt /datadog_api_key.txt

USER airflow
