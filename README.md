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
| master/HEAD               | Orchestrate v21.10.x or higher |
| v2.0.0                    | Orchestrate v21.10.x or higher |
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
| `global.environment`               | Common environment variables for the API, Tx sender, Tx listener                            | `{}`                                                        |
| `global.environmentSecrets`        | Common environment variables (as Kubernetes secrets)  for the API, Tx sender, Tx listener   | `{}`                                                        |
| `global.existingSecret`            | If specified, extra environment variables will be added from externally created secret                   | `nil`                                                       |
| `global.imageCredentials.create`   | If true, create a secret containing the image credentials                                                | `false`                                                     |
| `global.imageCredentials.name`     | Name of the secret                                                                                       | `existing-secret`                                           |
| `global.imageCredentials.registry` | Docker registry where Orchestrate images are stored                                                      | `docker.consensys.net`                                      |
| `global.imageCredentials.username` | Username of the registry                                                                                 | `someone`                                                   |
| `global.imageCredentials.password` | Password of the registry                                                                                 | `sillyness`                                                 |
| `global.image.repository`          | Path to Orchestrate image                                                                                | `docker.consensys.net/priv/orchestrate` |
| `global.image.tag`                 | Orchestrate image tag                                                                                    | `v21.1.5`                                                   |
| `global.image.pullPolicy`          | Orchestrate image pull policy                                                                            | `IfNotPresent`                                              |
| `global.serviceMonitor.enabled`    | If true, create a ServiceMonior for prometheus operator                                                  | `false`                                                     |
| `global.qkm.tls.enabled`    | Enables communication with a tls qkm                                                  | `true`                                                     |
| `global.qkm.tls.client.ca`    | The qkm client CA                                                  | ""                                                    |
| `global.qkm.tls.client.key`    | The qkm client key                                                 | ""                                                  |
| `global.qkm.tls.client.crt`    | The qkm client crt                                                  | ""                                                    |

### API parameters

| Parameter                                                | Description                                                                                                            | Default             |
|----------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|---------------------|
| `api.enabled`                                            | Deploy API                                                                                                             | `true`              |
| `api.replicaCount`                                       | Number of Orchestrate API replicas                                                                                     | `1`                 |
| `api.ingress.enabled`                                    | Enable ingress controller resource                                                                                     | `false`             |
| `api.ingress.annotations`                                | Ingress annotations                                                                                                    | `{}`                |
| `api.ingress.hosts[0].host`                              | Hostname to your Orchestrate API                                                                                       | `orchestrate.local` |
| `api.ingress.hosts[0].http.paths[0].path`                | Path within the url structure                                                                                          | `/`                 |
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
| `api.existingSecret`                                     | If specified, extra environment variables will be added from externally created secret                                 | `nil`               |
| `api.auth.jwt.issuerUrl`                                     | Jwt token issuer. is mapped to `AUTH_JWT_ISSUER_URL`                                | ""              |
| `api.auth.jwt.audience`                                      | Jwt token audience. is mapped to `AUTH_JWT_AUDIENCE`                               | ""              |
| `api.auth.jwt.claims`                                    | Jwt token specific claims for orchestrate is mapped to `AUTH_JWT_ORCHESTRATE_CLAIMS`                                | ""               |
| `migrate.backoffLimit`                           | Number of retries before considering the  migration as failed                             | `6`                 |
| `migrate.environment`                                        | Migration Environment variables passed to Orchestrate API containers                                                             | `{}`    |
| `migrate.environmentSecrets`                                 | Migration Environment variables (as Kubernetes secrets) passed to Orchestrate API containers                                     | `{}`            |


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
| `txSender.podAnnotations`             | Annotations to add to the Orchestrate Tx Sender's pods                                                               | `{}`        |
| `txSender.podSecurityContext`         | Pod security context                                                                                                   | `{}`        |
| `txSender.securityContext`            | Container security context                                                                                             | `{}`        |
| `txSender.resources.limits`           | The resources limits for Orchestrate Tx Sender containers                                                              | `{}`        |
| `txSender.resources.requests`         | The requested resources for Orchestrate Tx Sender containers                                                           | `{}`        |
| `txSender.nodeSelector`               | Node labels for pod assignment                                                                                         | `{}`        |
| `txSender.tolerations`                | Tolerations for pod assignment                                                                                         | `[]`        |
| `txSender.affinity`                   | Affinity for pod assignment                                                                                            | `{}`        |
| `txSender.environment`                | Environment variables passed to Orchestrate Tx Sender containers                                                       | `{}`        |
| `txSender.environmentSecrets`         | Environment variables (as Kubernetes secrets) passed to Orchestrate Tx Sender containers                             | `{}`        |
| `txSender.existingSecret`             | If specified, extra environment variables will be added from externally created secret                                 | `nil`       |

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
| `txListener.podAnnotations`             | Annotations to add to the Orchestrate Tx Listener's pods                                                               | `{}`        |
| `txListener.podSecurityContext`         | Pod security context                                                                                                   | `{}`        |
| `txListener.securityContext`            | Container security context                                                                                             | `{}`        |
| `txListener.resources.limits`           | The resources limits for Orchestrate Tx Listener containers                                                            | `{}`        |
| `txListener.resources.requests`         | The requested resources for Orchestrate Tx Listener containers                                                         | `{}`        |
| `txListener.nodeSelector`               | Node labels for pod assignment                                                                                         | `{}`        |
| `txListener.tolerations`                | Tolerations for pod assignment                                                                                         | `[]`        |
| `txListener.affinity`                   | Affinity for pod assignment                                                                                            | `{}`        |
| `txListener.environment`                | Environment variables passed to Orchestrate Tx Listener containers                                                     | `{}`        |
| `txListener.environmentSecrets`         | Environment variables (as Kubernetes secrets) passed to Orchestrate Key Manager containers                             | `{}`        |
| `txListener.existingSecret`             | If specified, extra environment variables will be added from externally created secret                                 | `nil`       |

### Test parameters

| Parameter                  | Description                                                                        | Default                                                         |
|----------------------------|------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| `test.enabled`             | Deploy Orchestrate tests                                                           | `false`                                                         |
| `test.image.repository`    | Path to Orchestrate test image                                                     | `docker.consensys.net/priv/orchestrate-e2e` |
| `test.image.tag`           | Orchestrate test image tag                                                         | `v21.1.5`                                                       |
| `test.cmd`                 | Orchestrate test command                                                           | `e2e`                                                           |
| `test.environment`         | Environment variables passed to Orchestrate test container                         | `{}`                                                            |
| `test.environmentSecrets`  | Environment variables (as Kubernetes secrets) passed to Orchestrate test container | `{}`                                                            |
| `test.report.enabled`      | Environment variables (as Kubernetes secrets) passed to Orchestrate test container | `false`                                                         |
| `test.report.storageClass` | Environment variables (as Kubernetes secrets) passed to Orchestrate test container | ``                                                              |

### Quorum Key Manager

Please refer to https://github.com/ConsenSys/quorum-key-manager-helm for detailed configuration options of Quorum key manager when deployed


```console
$ helm install orchestrate \
               --set global.imageCredentials.username=my-user \
               --set global.imageCredentials.password=my-passsword \
               helm-consensys/orchestrate
```

The above command sets the credentials to access the Orchestrate Docker repository (default docker.consensys.net).

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install orchestrate -f values.yaml helm-consensys/orchestrate
```
