{{/*
Expand the name of the chart.
*/}}
{{- define "lightspin-kubecollector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "lightspin-kubecollector.runtime.falco.name" -}}
{{- default .Values.runtime.falco.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "lightspin-kubecollector.runtime.events.name" -}}
{{- default .Values.runtime.events.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lightspin-kubecollector.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lightspin-kubecollector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lightspin-kubecollector.labels" -}}
helm.sh/chart: {{ include "lightspin-kubecollector.chart" . }}
{{ include "lightspin-kubecollector.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lightspin-kubecollector.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lightspin-kubecollector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lightspin-kubecollector.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lightspin-kubecollector.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified broker name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lightspin-kubecollector.broker.fullname" -}}
{{- if .Values.broker.fullnameOverride -}}
{{- .Values.broker.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.broker.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.broker.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified beat name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lightspin-kubecollector.beat.fullname" -}}
{{- if .Values.beat.fullnameOverride -}}
{{- .Values.beat.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.beat.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.beat.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified worker name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lightspin-kubecollector.worker.fullname" -}}
{{- if .Values.worker.fullnameOverride -}}
{{- .Values.worker.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.worker.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.worker.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified runtime falco name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lightspin-kubecollector.runtime.falco.fullname" -}}
{{- if .Values.runtime.falco.fullnameOverride -}}
{{- .Values.runtime.falco.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.runtime.falco.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.runtime.falco.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified runtime events name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lightspin-kubecollector.runtime.events.fullname" -}}
{{- if .Values.runtime.events.fullnameOverride -}}
{{- .Values.runtime.events.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.runtime.events.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.runtime.events.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the worker component
*/}}
{{- define "lightspin-kubecollector.worker.serviceAccountName" -}}
{{ template "lightspin-kubecollector.name" . }}-secaudit
{{- end -}}

{{/*
Create unified labels for lightspin-kubecollector components
*/}}
{{- define "lightspin-kubecollector.common.matchLabels" -}}
app: {{ template "lightspin-kubecollector.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{- define "lightspin-kubecollector.common.metaLabels" -}}
chart: {{ template "lightspin-kubecollector.chart" . }}
heritage: {{ .Release.Service }}
{{- if .Values.commonLabels}}
{{ toYaml .Values.commonLabels }}
{{- end }}
{{- end -}}

{{- define "lightspin-kubecollector.broker.matchLabels" -}}
component: {{ .Values.broker.name }}
{{ include "lightspin-kubecollector.common.matchLabels" . }}
{{- end -}}

{{- define "lightspin-kubecollector.broker.labels" -}}
{{ include "lightspin-kubecollector.broker.matchLabels" . }}
{{ include "lightspin-kubecollector.common.metaLabels" . }}
{{- end -}}

{{- define "lightspin-kubecollector.beat.matchLabels" -}}
component: {{ .Values.beat.name }}
{{ include "lightspin-kubecollector.common.matchLabels" . }}
{{- end -}}

{{- define "lightspin-kubecollector.beat.labels" -}}
{{ include "lightspin-kubecollector.beat.matchLabels" . }}
{{ include "lightspin-kubecollector.common.metaLabels" . }}
{{- end -}}

{{- define "lightspin-kubecollector.worker.matchLabels" -}}
component: {{ .Values.worker.name }}
{{ include "lightspin-kubecollector.common.matchLabels" . }}
{{- end -}}

{{- define "lightspin-kubecollector.worker.labels" -}}
{{ include "lightspin-kubecollector.worker.matchLabels" . }}
{{ include "lightspin-kubecollector.common.metaLabels" . }}
{{- end -}}

{{- define "lightspin-kubecollector.runtime.falco.matchLabels" -}}
app: {{ template "lightspin-kubecollector.runtime.falco.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{- define "lightspin-kubecollector.runtime.falco.labels" -}}
{{ include "lightspin-kubecollector.runtime.falco.matchLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use for the runtime falco component
*/}}
{{- define "lightspin-kubecollector.runtime.falco.serviceAccountName" -}}
{{ template "lightspin-kubecollector.runtime.falco.name" . }}-secaudit
{{- end -}}

{{- define "lightspin-kubecollector.runtime.events.matchLabels" -}}
app: {{ template "lightspin-kubecollector.runtime.events.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{- define "lightspin-kubecollector.runtime.events.labels" -}}
{{ include "lightspin-kubecollector.runtime.events.matchLabels" . }}
{{- end -}}

{{- define "lightspin-kubecollector.namespace" -}}
{{- if .Values.namespace.forceNamespace -}}
namespace: {{ .Values.namespace.forceNamespace }}
{{- else -}}
namespace: {{ .Release.Namespace }}
{{- end -}}
{{- end -}}

{{- define "lightspin-kubecollector.broker.url" -}}
{{- printf "redis://lightspin-kubecollector-redis:%d/" (.Values.broker.config.port | int) -}}
{{- end -}}