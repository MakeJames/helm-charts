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
Qualify Image Name
*/}}
{{- define "postgres.image" }}
    {{- if .Values.imageOverride }}
        {{- .Values.imageOverride }}
    {{- else }}
        {{- with .Values.image }}
            {{- printf "%s/%s:%s" .registry .repository .tag }}
        {{- end }}
    {{- end }}
{{- end }}

{{/*
Qualify Chart name
*/}}
{{- define "postgres.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Qualify volume name
*/}}
{{- define "postgres.volume.name" -}}
{{- printf "%s-%s" .Chart.Name "storage" | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "postgres.volume.claimName" -}}
{{- printf "%s-%s" .Chart.Name "persistent-volumne-claim" | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "postgres.labels" }}
{{- if not .hideChartVersion }}
helm.sh/chart: {{ include "postgres.chart" . | quote }}
{{- end }}
app: {{include "postgres.fullname" . | quote }}
deploymentconfig: {{ include "postgres.fullname" . | quote }}
app/name: {{ include "postgres.name" . | quote }}
app/instance: {{ .Release.Name | quote }}
{{- if .Chart.AppVersion }}
app/version: {{ .Chart.AppVersion | quote }}
image/repository: {{ .Values.image.repository | quote }}
image/registry: {{ .Values.image.registry | quote }}
image/tag: {{ .Values.image.tag | quote }}
{{- end }}
{{- end -}}
