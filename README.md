# freshrss-kubernetes

A project to deploy [FreshRSS](https://freshrss.org/) in a scalable and secure way on Kubernetes

Features:
- Automatic creation of initial superuser
- Secure setup with no root in any container and read-only root filesystem
- Seperated static file serving using rootless NGINX

## Installation
Add the helm repo by running
```
helm repo add mystarinyoursky-freshrss http://freshrss.helm.mystarinyoursky.net
```

Install the helm chart by running
```
helm install freshrss mystarinyoursky-freshrss/freshrss -f values.yaml
```

## Chart Values
| Parameter | Default | Description |
|-----------|---|---|
| freshrss.user.uid | `1000` | Default UID that the FreshRSS container will run with |
| freshrss.user.gid | `1000` | Default GID that the FreshRSS container will run with |
| freshrss.timezone | `Europe/London` | Timezone that the FreshRSS installation will run with |
| freshrss.image.repository | `ghcr.io/mystarinyoursky/freshrss` | The image repository that will be used to run FreshRSS |
| freshrss.image.tag | `appVersion` of the Chart | The version of the image that will be used to run FreshRSS |
| freshrss.image.pullPolicy | `Always` | Pull policy of the FreshRSS image |
| freshrss.replicaCount | `1` | Number of replicas of FreshRSS to run |
| freshrss.storage.data.storageClassName | `default` | Storage class for FreshRSS data |
| freshrss.storage.data.size | `20G` | Storage size for the FreshRSS data |
| freshrss.storage.extensions.storageClassName | `default` | Storage class for FreshRSS extensions |
| freshrss.storage.extensions.size | `5G` | Storage size for the FreshRSS extensions |
| freshrss.nodeSelector | `{}` | TODO |
| freshrss.tolerations | `[]` | TODO |
| freshrss.affinity | `{}` | TODO |
| freshrss.podAnnotations | `{}` | TODO |
| freshrss.podSecurityContext | `{fsGroup: 1000}` | TODO |
| freshrss.imagePullSecrets | `[]` | Image pull secrets |
| freshrss.setting.database.type | `sqlite` | Options are `sqlite`, `postgres`, and `mysql` |
| freshrss.setting.database.host | `""` | Hostname of the database server if you are using `postgres` or `mysql` |
| freshrss.setting.database.user | `""` | User of the database server if you are using `postgres` or `mysql` |
| freshrss.setting.database.password | `""` | Password of the database server if you are using `postgres` or `mysql` |
| freshrss.setting.database.dbname | `""` | Database name if you are using `postgres` or `mysql` |
| freshrss.setting.database.dbprefix | `""` | Database prefix if you are using `postgres` or `mysql` |
| freshrss.setting.admin.user | `admin` | Username of the FreshRSS admin user |
| freshrss.setting.admin.password | `adminpass` | Password of the FreshRSS admin user |
| freshrss.setting.language | `en` | Default language of FreshRSS |
| freshrss.setting.title | `FreshRSS` | Name of FreshRSS installation |
| freshrss.setting.base_url | `https://freshrss.org` | URL of the FreshRSS installation |
| freshrss.setting.allow_robots | `false` | Whether robot users are allowed |
| freshrss.setting.allow_anonymous | `false` | Whether anonymous users can use the service |
| freshrss.setting.allow_anonymous_refresh | `false` | Whether anonymous users can refresh the feed |
| freshrss.setting.api_enabled | `false` | Whether the API of FreshRSS is enabled |
| freshrss.securityContext | `{securityContext: {capabilities: {drop: [ALL]}, readOnlyRootFilesystem: true, runAsUser: 1000, runAsGroup: 1000}}` | Security Context of the FreshRSS pod |
| freshrss.tmpStorage | `256Mi` | Amount of in-memory /tmp storage for FreshRSS |
| freshrss.resources | `{limits: {cpu: 500m, memory: 512Mi}, requests: {cpu: 250m, memory: 512Mi}}` | Resource limits and requests of FreshRSS |
| freshrss.cron | `*/5 * * * *` | How often the FreshRSS feeds are refreshed |
| webserver.storage.webserver.storageClassName | `default` | Storage class for FreshRSS static files |
| webserver.storage.webserver.size | `1G` | Storage size for FreshRSS static files |
| webserver.image.repository | `nginxinc/nginx-unprivileged` | The image repository that will be used to run NGINX |
| webserver.image.pullPolicy | `Always` | Pull policy of the NGINX image |
| webserver.image.tag | `latest` | Image tag of the NGINX image |
| webserver.securityContext | `{capabilities: {drop: [ALL]}, runAsUser: 101, runAsGroup: 101, readOnlyRootFilesystem: true}` | Security Context of the FreshRSS pod |
| webserver.nodeSelector | `{}` | TODO |
| webserver.tolerations | `[]` | TODO |
| webserver.affinity | `{}` | TODO |
| webserver.podAnnotations | `{}` | TODO |
| webserver.podSecurityContext | `{fsGroup: 1000}` | TODO |
| webserver.tmpStorage | `256Mi` | Amount of in-memory /tmp storage for NGINX |
| webserver.imagePullSecrets | `[]` | Image pull secrets |
| webserver.resources | `{limits: {cpu: 100m, memory: 128Mi}, requests: {cpu: 100m, memory: 128Mi}}` | Resource limits and requests of the NGINX pod |

