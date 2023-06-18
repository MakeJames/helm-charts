{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "postgres.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "postgres.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{ printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Qualify Chart name
*/}}
{{- define "postgres.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Common labels
*/}}
{{- define "postgres.labels"}}
{{- if not .hideChartVersion }}
helm.sh/chart: {{ include "postgres.chart" . | quote }}
{{- end }}
app: {{include "postgres.fullname" . | quote }}
deploymentconfig: {{ include "postgres.fullname" . | quote }}
app.kubernetes.io/name: {{ include "postgres.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- if .Chart.AppVersion }}
app.kubvernetes/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}
