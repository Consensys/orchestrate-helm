# CHANGELOG

All notable changes to this project will be documented in this file.

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
