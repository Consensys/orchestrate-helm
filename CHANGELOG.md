# CHANGELOG

All notable changes to this project will be documented in this file.

## v1.0.1 (Unreleased)

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
