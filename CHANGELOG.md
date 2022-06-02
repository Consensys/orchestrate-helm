# CHANGELOG

All notable changes to this project will be documented in this file.

## v2.0.7 (2022-05-31)
 * Migrations are run for every deployment as a Job
 * Migrations env disappear for API env
 * All helm hooks triggering have been removed
 * Import account removed

## v2.0.6 (2022-05-25)
 * Usage of existing secret with migrations

## v2.0.5 (2022-05-25)
 * Update app version

## v2.0.4 (2022-04-22)
 * New drop database Job on upgrade enabled for QA
 * New Migrate up Job on upgrade enabled for QA

## v2.0.3 (2022-04-05)
 * Align service port

## v2.0.2 (2022-03-17)
 * Introduce a new import accounts Job

## v2.0.1 (2022-02-23)
### 🛠 Bug fixes
 * imagePullSecrets was missing in api deployment

## v2.0.0 (2021-12-16)
 * Remove previous usage of keyManager component
 * Add support for Quorum Key Manager
 * Update Ingress api version to networking.k8s.io/v1 
### 🛠 Bug fixes
 * Fixed Migration issues

## v1.0.8 (2021-12-07)
* Allow users to not define KEY MANAGER envs
* Separate hook env and pre-install, pre-update

## v1.0.7 (2021-12-03)
### 🛠 Bug fixes
- Triggers vault agent restart on every key-manager restart so token is always available

## v1.0.6 (2021-11-29)
### 🛠 Bug fixes
 * Remove KEy_MANAGER environment variables when service is disabled

## v1.0.5 (2021-08-27)
### 🛠 Bug fixes
 * Remove duplicated labels in helpers for kutomize v4

## v1.0.4 (2021-06-02)
### 🛠 Bug fixes
 * Wrap initContainers into `{{- if .Values.api.migrate.enabled }}` to avoid error in case its value is `false`

## v1.0.3 (2021-06-02)

 * Update default image repository to `docker.consensys.net`
 * Bump default image tag to `v21.1.5`
  
## v1.0.2 (2021-03-05)

 * Run Vault Agent as sidecar container instead in initContainer only. The Vault Agent will be responsible to renew the vault token for the key manager. Ability to wrap-token instead of plaintext with `keyManager.vaultAgent.config.wrapTTL`


## v1.0.1 (2021-02-18)

 * Add sticky sessions for the API cache
 * Add ability to specify externally created secrets

## v1.0.0 (2021-01-25)

### 🛠 Features
 * Compatible with Orchestrate v21.1.X and deploys all Orchestrate stack in the same chart, ie. API, Key-Manager, Tx-Sender and Tx-Listener
 * Reshape values:
   * global
   * api
   * keyManager
   * txListener
   * txSender
   * test
 * Deploy a service monitor for Prometheus on demand
 * Chart compatible to run the stress test
 * Chart compatible to run `api migrate copy-db` and `key-manager migrate import-secrets` to upgrade from Orchesrate v2.5.X to v21.1.X
