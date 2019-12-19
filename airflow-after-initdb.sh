DATADOG_API_KEY=$(</datadog_api_key.txt)
if [ -z "$DATADOG_API_KEY" ]
then
	>&2 echo "/datadog_api_key.txt is empty"
	exit 1
fi
airflow connections --add --conn_id datadog_default --conn_type HTTP --conn_extr "{\"api_key\": \"${DATADOG_API_KEY}\"}"
