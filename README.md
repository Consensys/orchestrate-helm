[![Website](https://img.shields.io/website?label=documentation&url=https%3A%2F%2Fdocs.orchestrate.pegasys.tech%2F)](https://docs.orchestrate.pegasys.tech/)
[![Website](https://img.shields.io/website?label=website&url=https%3A%2F%2Fpegasys.tech%2Forchestrate%2F)](https://pegasys.tech/orchestrate/)

[![Website](https://img.shields.io/website?label=charts%20repository&url=https%3A%2F%2Fpegasys.jfrog.io%2Fartifactory%2Fhelm-pegasys)](https://pegasys.jfrog.io/artifactory/helm-pegasys)

# Codefi Orchestrate

[Orchestrate](https://codefi.consensys.net) is a platform that enables enterprises to easily build
secure and reliable applications on Ethereum blockchains.

It provides extensive features to connect to blockchain networks:

- Transaction management (transaction crafting, gas management, nonce management, transaction listening)
- Account management with private key storage in Hashicorp Vault
- Smart Contract Registry
- Multi-chain & Multi-protocol (public or private)

For more information, refer to the [Orchestrate documentation](https://docs.orchestrate.consensys.net/).

# Orchestrate Helm Chart

[Orchestrate](https://codefi.consensys.net) is a platform that enables enterprises to easily build
secure and reliable applications on Ethereum blockchains.

## Introduction

This chart bootstraps an [Orchestrate](https://github.com/bitnami/bitnami-docker-airflow) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.17+
- Helm 3+

## Installing the Chart

To install the chart with the release name `orchestrate`:

```console
$ helm repo add helm-consensys https://artifacts.consensys.net/public/helm/helm/charts/
$ helm install orchestrate helm-consensys/orchestrate
```

These commands deploy Orchestrate on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

[See an example of the Chart with Orchestrate dependencies with Helmfile](https://github.com/ConsenSys/orchestrate-kubernetes).

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `orchestrate` deployment:

```console
$ helm delete orchestrate
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

# Compatibility

| Orchestrate-Helm versions | Orchestrate versions          |
|---------------------------|-------------------------------|
| master/HEAD               | Orchestrate v21.1.x or higher |
| v1.0.0                    | Orchestrate v21.1.x or higher |

For older versions of Orchestrate please see https://github.com/ConsenSys/orchestrate-helm-worker and https://github.com/ConsenSys/orchestrate-helm-api

## Parameters

The following tables lists the configurable parameters of the Orchestrate chart and their default values.

### Global parameters

| Parameter                          | Description                                                                                              | Default                                                     |
|------------------------------------|----------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| `global.nameOverride`              | String to partially override orchestrate.fullname template with a string (will prepend the release name) | `nil`                                                       |
| `global.fullnameOverride`          | String to fully override orchestrate.fullname template with a string                                     | `nil`                                                       |
| `global.labels`                    | Labels to add to all deploye                                                                             | `{}`                                                        |
| `global.environment`               | Common environment variables for the API, Key Manager, Tx sender, Tx listener                            | `{}`                                                        |
| `global.environmentSecrets`        | Common environment variables (as Kubernetes secrets)  for the API, Key Manager, Tx sender, Tx listener   | `{}`                                                        |
| `global.imageCredentials.create`   | If true, create a secret containing the image credentials                                                | `false`                                                     |
| `global.imageCredentials.name`     | Name of the secret                                                                                       | `existing-secret`                                           |
| `global.imageCredentials.registry` | Docker registry where Orchestrate images are stored                                                      | `docker.cloudsmith.io`                                      |
| `global.imageCredentials.username` | Username of the registry                                                                                 | `someone`                                                   |
| `global.imageCredentials.password` | Password of the registry                                                                                 | `sillyness`                                                 |
| `global.image.repository`          | Path to Orchestrate image                                                                                | `docker.cloudsmith.io/consensys/docker-private/orchestrate` |
| `global.image.tag`                 | Orchestrate image tag                                                                                    | `v21.1.0`                                                   |
| `global.image.pullPolicy`          | Orchestrate image pull policy                                                                            | `IfNotPresent`                                              |
| `global.serviceMonitor.enabled`    | If true, create a ServiceMonior for prometheus operator                                                  | `false`                                                     |

### API parameters

| Parameter                                                | Description                                                                                                            | Default             |
|----------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|---------------------|
| `api.enabled`                                            | Deploy API                                                                                                             | `true`              |
| `api.replicaCount`                                       | Number of Orchestrate API replicas                                                                                     | `1`                 |
| `api.ingress.enabled`                                    | Enable ingress controller resource                                                                                     | `false`             |
| `api.ingress.annotations`                                | Ingress annotations                                                                                                    | `{}`                |
| `api.ingress.hosts[0].host`                              | Hostname to your Orchestrate API                                                                                       | `orchestrate.local` |
| `api.ingress.hosts[0].http.paths[0].path`                | Path within the url structure                                                                                          | `/`                 |
| `api.ingress.hosts[0].http.paths[0].backend.servicePort` | Service port to serve                                                                                                  | `http-svc`          |
| `api.ingress.tls[0].secretName`                          | TLS Secret Name                                                                                                        | `nil`               |
| `api.ingress.tls[0].hosts`                               | Array of TLS hosts for ingress record                                                                                  | `[]`                |
| `api.service.type`                                       | Kubernetes Service type                                                                                                | `ClusterIP`         |
| `api.service.sessionAffinity`                            | Session Affinity for sticky sessions                                                                                   | `ClientIP`          |
| `api.service.sessionAffinityTimeout`                     | Timeout for session affinity                                                                                           | `10`                |
| `api.service.http.port`                                  | Orchestrate API port                                                                                                   | `8081`              |
| `api.service.metrics.port`                               | Orchestrate API metrics port                                                                                           | `8082`              |
| `api.serviceAccount.create`                              | If true, create a service account                                                                                      | `false`             |
| `api.serviceAccount.annotations`                         | Annotations for service account                                                                                        | `{}`                |
| `api.serviceAccount.name`                                | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | ``                  |
| `api.podAnnotations`                                     | Annotations to add to the Orchestrate API's pods                                                                       | `{}`                |
| `api.podSecurityContext`                                 | Pod security context                                                                                                   | `{}`                |
| `api.securityContext`                                    | Container security context                                                                                             | `{}`                |
| `api.resources.limits`                                   | The resources limits for Orchestrate API containers                                                                    | `{}`                |
| `api.resources.requests`                                 | The requested resources for Orchestrate API containers                                                                 | `{}`                |
| `api.nodeSelector`                                       | Node labels for pod assignment                                                                                         | `{}`                |
| `api.tolerations`                                        | Tolerations for pod assignment                                                                                         | `[]`                |
| `api.affinity`                                           | Affinity for pod assignment                                                                                            | `{}`                |
| `api.environment`                                        | Environment variables passed to Orchestrate API containers                                                             | `{}`                |
| `api.environmentSecrets`                                 | Environment variables (as Kubernetes secrets) passed to Orchestrate API containers                                     | `{}`                |
| `api.initMigrate.enabled`                                | Run migration initialization job                                                                                       | `true`              |
| `api.initMigrate.backoffLimit`                           | Number of retries before considering the initialization migration initialization as failed                             | `6`                 |
| `api.migrate`                                            | Run migration script                                                                                                   | `true`              |
| `api.copyDB.enabled`                                     | Run copy db job to migrate databases from Orchesrate v2.5.X Postgres databases to Orchestrate v21.1.X API database     | `false`             |
| `api.copyDB.backoffLimit`                                | Number of retries before considering the copy db as failed                                                             | `6`                 |
| `api.copyDB.params.chainRegistry.postgresAddress`        | Endpoint of Postgres database storing chain registry tables from Orchestrate v2.5.X                                    |                     |
| `api.copyDB.params.chainRegistry.database`               | Postgres database name storing chain registry tables from Orchestrate v2.5.X                                           |                     |
| `api.copyDB.params.chainRegistry.username`               | Postgres username                                                                                                      |                     |
| `api.copyDB.params.chainRegistry.password`               | Postgres password                                                                                                      |                     |
| `api.copyDB.params.contractRegistry.postgresAddress`     | Endpoint of Postgres database storing contract registry tables from Orchestrate v2.5.X                                 |                     |
| `api.copyDB.params.contractRegistry.database`            | Postgres database name storing contract registry tables from Orchestrate v2.5.X                                        |                     |
| `api.copyDB.params.contractRegistry.username`            | Postgres username                                                                                                      |                     |
| `api.copyDB.params.contractRegistry.password`            | Postgres password                                                                                                      |                     |
| `api.copyDB.params.transactionScheduler.postgresAddress` | Endpoint of Postgres database storing transaction scheduler tables from Orchestrate v2.5.X                             |                     |
| `api.copyDB.params.transactionScheduler.database`        | Postgres database name storing transaction scheduler tables from Orchestrate v2.5.X                                    |                     |
| `api.copyDB.params.transactionScheduler.username`        | Postgres username                                                                                                      |                     |
| `api.copyDB.params.transactionScheduler.password`        | Postgres password                                                                                                      |                     |

### Key Manager parameters

| Parameter                                | Description                                                                                                            | Default     |
|------------------------------------------|------------------------------------------------------------------------------------------------------------------------|-------------|
| `keyManager.enabled`                     | Deploy Key Manager                                                                                                     | `true`      |
| `keyManager.replicaCount`                | Number of Orchestrate Key Manager replicas                                                                             | `1`         |
| `keyManager.service.type`                | Kubernetes Service type                                                                                                | `ClusterIP` |
| `keyManager.service.http.port`           | Orchestrate Key Manager port                                                                                           | `8081`      |
| `keyManager.service.metrics.port`        | Orchestrate Key Manager metrics port                                                                                   | `8082`      |
| `keyManager.serviceAccount.create`       | If true, create a service account                                                                                      | `false`     |
| `keyManager.serviceAccount.annotations`  | Annotations for service account                                                                                        | `{}`        |
| `keyManager.serviceAccount.name`         | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | ``          |
| `keyManager.podAnnotations`              | Annotations to add to the Orchestrate Key Manager's pods                                                               | `{}`        |
| `keyManager.podSecurityContext`          | Pod security context                                                                                                   | `{}`        |
| `keyManager.securityContext`             | Container security context                                                                                             | `{}`        |
| `keyManager.resources.limits`            | The resources limits for Orchestrate keyManager containers                                                             | `{}`        |
| `keyManager.resources.requests`          | The requested resources for Orchestrate keyManager containers                                                          | `{}`        |
| `keyManager.nodeSelector`                | Node labels for pod assignment                                                                                         | `{}`        |
| `keyManager.tolerations`                 | Tolerations for pod assignment                                                                                         | `[]`        |
| `keyManager.affinity`                    | Affinity for pod assignment                                                                                            | `{}`        |
| `keyManager.environment`                 | Environment variables passed to Orchestrate keyManager containers                                                      | `{}`        |
| `keyManager.environmentSecrets`          | Environment variables (as Kubernetes secrets) passed to Orchestrate Key Manager containers                             | `{}`        |
| `keyManager.migrate`                     | Run import keys from Vault formated with Orchestrate v2.5.X to Orchestrate Vault plugin (used in v21.1.X)              | `false`     |
| `keyManager.vaultAgent.enabled`          | Run Vault Agent to retrieve the Key Manager client token from Hashicorp Vault                                          | `false`     |
| `keyManager.vaultAgent.role`             | Role eligible to retrieve a token                                                                                      | `client`    |
| `keyManager.vaultAgent.image.repository` | Hashicorp Vault image                                                                                                  | `vault`     |
| `keyManager.vaultAgent.image.tag`        | Hashicorp Vault tag                                                                                                    | `1.6.0`     |

### Tx Sender parameters

| Parameter                             | Description                                                                                                            | Default     |
|---------------------------------------|------------------------------------------------------------------------------------------------------------------------|-------------|
| `txSender.enabled`                    | Deploy Tx Sender                                                                                                       | `true`      |
| `txSender.replicaCount`               | Number of Orchestrate Tx Sender replicas                                                                               | `1`         |
| `txSender.service.type`               | Kubernetes Service type                                                                                                | `ClusterIP` |
| `txSender.service.metrics.port`       | Orchestrate Tx Sender metrics port                                                                                     | `8082`      |
| `txSender.serviceAccount.create`      | If true, create a service account                                                                                      | `false`     |
| `txSender.serviceAccount.annotations` | Annotations for service account                                                                                        | `{}`        |
| `txSender.serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | ``          |
| `txSender.podAnnotations`             | Annotations to add to the Orchestrate Key Manager's pods                                                               | `{}`        |
| `txSender.podSecurityContext`         | Pod security context                                                                                                   | `{}`        |
| `txSender.securityContext`            | Container security context                                                                                             | `{}`        |
| `txSender.resources.limits`           | The resources limits for Orchestrate Tx Sender containers                                                              | `{}`        |
| `txSender.resources.requests`         | The requested resources for Orchestrate Tx Sender containers                                                           | `{}`        |
| `txSender.nodeSelector`               | Node labels for pod assignment                                                                                         | `{}`        |
| `txSender.tolerations`                | Tolerations for pod assignment                                                                                         | `[]`        |
| `txSender.affinity`                   | Affinity for pod assignment                                                                                            | `{}`        |
| `txSender.environment`                | Environment variables passed to Orchestrate Tx Sender containers                                                       | `{}`        |
| `txSender.environmentSecrets`         | Environment variables (as Kubernetes secrets) passed to Orchestrate Key Manager containers                             | `{}`        |

### Tx Lisener parameters

| Parameter                               | Description                                                                                                            | Default     |
|-----------------------------------------|------------------------------------------------------------------------------------------------------------------------|-------------|
| `txListener.enabled`                    | Deploy Tx Listener                                                                                                     | `true`      |
| `txListener.replicaCount`               | Number of Orchestrate Tx Listener replicas                                                                             | `1`         |
| `txListener.service.type`               | Kubernetes Service type                                                                                                | `ClusterIP` |
| `txListener.service.metrics.port`       | Orchestrate Tx Listener metrics port                                                                                   | `8082`      |
| `txListener.serviceAccount.create`      | If true, create a service account                                                                                      | `false`     |
| `txListener.serviceAccount.annotations` | Annotations for service account                                                                                        | `{}`        |
| `txListener.serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | ``          |
| `txListener.podAnnotations`             | Annotations to add to the Orchestrate Key Manager's pods                                                               | `{}`        |
| `txListener.podSecurityContext`         | Pod security context                                                                                                   | `{}`        |
| `txListener.securityContext`            | Container security context                                                                                             | `{}`        |
| `txListener.resources.limits`           | The resources limits for Orchestrate Tx Listener containers                                                            | `{}`        |
| `txListener.resources.requests`         | The requested resources for Orchestrate Tx Listener containers                                                         | `{}`        |
| `txListener.nodeSelector`               | Node labels for pod assignment                                                                                         | `{}`        |
| `txListener.tolerations`                | Tolerations for pod assignment                                                                                         | `[]`        |
| `txListener.affinity`                   | Affinity for pod assignment                                                                                            | `{}`        |
| `txListener.environment`                | Environment variables passed to Orchestrate Tx Listener containers                                                     | `{}`        |
| `txListener.environmentSecrets`         | Environment variables (as Kubernetes secrets) passed to Orchestrate Key Manager containers                             | `{}`        |

### Test parameters

| Parameter                  | Description                                                                        | Default                                                         |
|----------------------------|------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| `test.enabled`             | Deploy Orchestrate tests                                                           | `false`                                                         |
| `test.image.repository`    | Path to Orchestrate test image                                                     | `docker.cloudsmith.io/consensys/docker-private/orchestrate-e2e` |
| `test.image.tag`           | Orchestrate test image tag                                                         | `v21.1.0`                                                       |
| `test.cmd`                 | Orchestrate test command                                                           | `e2e`                                                           |
| `test.environment`         | Environment variables passed to Orchestrate test container                         | `{}`                                                            |
| `test.environmentSecrets`  | Environment variables (as Kubernetes secrets) passed to Orchestrate test container | `{}`                                                            |
| `test.report.enabled`      | Environment variables (as Kubernetes secrets) passed to Orchestrate test container | `false`                                                         |
| `test.report.storageClass` | Environment variables (as Kubernetes secrets) passed to Orchestrate test container | ``                                                              |


```console
$ helm install orchestrate \
               --set global.imageCredentials.username=my-user \
               --set global.imageCredentials.password=my-passsword \
               helm-consensys/orchestrate
```

The above command sets the credentials to access the Orchestrate Docker repository (default docker.cloudsmith.io).

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install orchestrate -f values.yaml helm-consensys/orchestrate
```