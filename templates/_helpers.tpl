{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "orchestrate.name" -}}
{{- default .Chart.Name .Values.global.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "orchestrate.fullname" -}}
{{- if .Values.global.fullnameOverride -}}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.global.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Name suffixed with api */}}
{{- define "orchestrate.api.name" -}}
{{- printf "%s-api" (include "orchestrate.name" .) -}}
{{- end }}

{{/* Name suffixed with keyManager */}}
{{- define "orchestrate.keyManager.name" -}}
{{- printf "%s-key-manager" (include "orchestrate.name" .) -}}
{{- end }}

{{/* Name suffixed with tx-listener */}}
{{- define "orchestrate.txListener.name" -}}
{{- printf "%s-tx-listener" (include "orchestrate.name" .) -}}
{{- end }}

{{/* Name suffixed with tx-sender */}}
{{- define "orchestrate.txSender.name" -}}
{{- printf "%s-tx-sender" (include "orchestrate.name" .) -}}
{{- end }}


{{/* Fullname suffixed with api */}}
{{- define "orchestrate.api.fullname" -}}
{{- printf "%s-api" (include "orchestrate.fullname" .) -}}
{{- end }}

{{/* Fullname suffixed with keyManager */}}
{{- define "orchestrate.keyManager.fullname" -}}
{{- printf "%s-key-manager" (include "orchestrate.fullname" .) -}}
{{- end }}

{{/* Fullname suffixed with tx-listener */}}
{{- define "orchestrate.txListener.fullname" -}}
{{- printf "%s-tx-listener" (include "orchestrate.fullname" .) -}}
{{- end }}

{{/* NaFullnameme suffixed with tx-sender */}}
{{- define "orchestrate.txSender.fullname" -}}
{{- printf "%s-tx-sender" (include "orchestrate.fullname" .) -}}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "orchestrate.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define imageCredentials name.
*/}}
{{- define "orchestrate.imagePullSecretName" -}}
{{- if .Values.global.imageCredentials.create -}}
	{{ printf "%s-%s" (include "orchestrate.fullname" .) "registry" | trunc 63 | trimSuffix "-" }}
{{- else -}}
	{{ .Values.global.imageCredentials.name }}
{{- end -}}
{{- end -}}

{{- define "orchestrate.imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.global.imageCredentials.registry (printf "%s:%s" .Values.global.imageCredentials.username .Values.global.imageCredentials.password | b64enc) | b64enc }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "orchestrate.annotations" -}}
meta.helm.sh/release-name: {{ .Release.Name }}
meta.helm.sh/release-namespace: {{ .Release.Namespace }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "orchestrate.labels" -}}
app.kubernetes.io/name: {{ include "orchestrate.name" . }}
helm.sh/chart: {{ include "orchestrate.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{ include "orchestrate.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Labels for api
*/}}
{{- define "orchestrate.api.labels" -}}
{{ include "orchestrate.labels" . }}
app.kubernetes.io/component: api
{{- end -}}

{{/*
Labels for keyManager
*/}}
{{- define "orchestrate.keyManager.labels" -}}
{{ include "orchestrate.labels" . }}
app.kubernetes.io/component: key-manager
{{- end -}}

{{/*
Labels for tx-listener
*/}}
{{- define "orchestrate.txListener.labels" -}}
{{ include "orchestrate.labels" . }}
app.kubernetes.io/component: tx-listener
{{- end -}}

{{/*
Labels for tx-sender
*/}}
{{- define "orchestrate.txSender.labels" -}}
{{ include "orchestrate.labels" . }}
app.kubernetes.io/component: tx-sender
{{- end -}}

{{/*
Common selectorLabels
*/}}
{{- define "orchestrate.selectorLabels" -}}
app.kubernetes.io/name: {{ include "orchestrate.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
SelectorLabels for api
*/}}
{{- define "orchestrate.api.selectorLabels" -}}
{{ include "orchestrate.selectorLabels" . }}
app.kubernetes.io/component: api
{{- end -}}

{{/*
SelectorLabels for keyManager
*/}}
{{- define "orchestrate.keyManager.selectorLabels" -}}
{{ include "orchestrate.selectorLabels" . }}
app.kubernetes.io/component: key-manager
{{- end -}}

{{/*
SelectorLabels for tx-listener
*/}}
{{- define "orchestrate.txListener.selectorLabels" -}}
{{ include "orchestrate.selectorLabels" . }}
app.kubernetes.io/component: tx-listener
{{- end -}}

{{/*
SelectorLabels for tx-sender
*/}}
{{- define "orchestrate.txSender.selectorLabels" -}}
{{ include "orchestrate.selectorLabels" . }}
app.kubernetes.io/component: tx-sender
{{- end -}}


{{/*
Define serviceAccountName name for api
*/}}
{{- define "orchestrate.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create }}
{{- default (include "orchestrate.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.api.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Define serviceAccountName name for keyManager
*/}}
{{- define "orchestrate.keyManager.serviceAccountName" -}}
{{- if .Values.keyManager.serviceAccount.create }}
{{- default (include "orchestrate.keyManager.fullname" .) .Values.keyManager.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.keyManager.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define serviceAccountName name for tx-listener
*/}}
{{- define "orchestrate.txListener.serviceAccountName" -}}
{{- if .Values.txListener.serviceAccount.create }}
{{- default (include "orchestrate.txListener.fullname" .) .Values.txListener.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.txListener.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define serviceAccountName name for tx-sender
*/}}
{{- define "orchestrate.txSender.serviceAccountName" -}}
{{- if .Values.txSender.serviceAccount.create }}
{{- default (include "orchestrate.txSender.fullname" .) .Values.txSender.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.txSender.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* Default key manager HTTP URL */}}
{{- define "orchestrate.keyManager.defaultHTTPURL" -}}
{{- printf "http://%s:%d" (include "orchestrate.keyManager.fullname" .) (int .Values.keyManager.service.http.port) -}}
{{- end }}

{{/* Default key manager Metrics URL */}}
{{- define "orchestrate.keyManager.defaultMetricsURL" -}}
{{- printf "http://%s:%d" (include "orchestrate.keyManager.fullname" .) (int .Values.keyManager.service.metrics.port) -}}
{{- end }}

{{/* Default api HTTP URL */}}
{{- define "orchestrate.api.defaultHTTPURL" -}}
{{- printf "http://%s:%d" (include "orchestrate.api.fullname" .) (int .Values.api.service.http.port) -}}
{{- end }}

{{/* Default api Metrics URL */}}
{{- define "orchestrate.api.defaultMetricsURL" -}}
{{- printf "http://%s:%d" (include "orchestrate.api.fullname" .) (int .Values.api.service.metrics.port) -}}
{{- end }}

{{/* Default txListener Metrics URL */}}
{{- define "orchestrate.txListener.defaultMetricsURL" -}}
{{- printf "http://%s:%d" (include "orchestrate.txListener.fullname" .) (int .Values.txListener.service.metrics.port) -}}
{{- end }}

{{/* Default txSender Metrics URL */}}
{{- define "orchestrate.txSender.defaultMetricsURL" -}}
{{- printf "http://%s:%d" (include "orchestrate.txSender.fullname" .) (int .Values.txSender.service.metrics.port) -}}
{{- end }}
