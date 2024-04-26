source '.env'
chmod +x ./front/entrypoint.sh
chmod +x ./time_manager/entrypoint.sh

docker compose build
docker compose down --remove-orphans
docker run -d --name dd-agent -e DD_API_KEY=${DD_API_KEY} -e DD_SITE=${DD_SITE} -e DD_APM_ENABLED=${DD_APM_ENABLED} -e DD_APM_NON_LOCAL_TRAFFIC=${DD_APM_NON_LOCAL_TRAFFIC} -e DD_APM_RECEIVER_SOCKET=${DD_APM_RECEIVER_SOCKET} -e DD_DOGSTATSD_SOCKET=${DD_DOGSTATSD_SOCKET} -v /opt/datadog/apm:/opt/datadog/apm -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -v /var/lib/docker/containers:/var/lib/docker/containers:ro gcr.io/datadoghq/agent:7
docker compose up --build --remove-orphans