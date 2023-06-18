#!/bin/bash

set -eu

PGHOST=localhost
export PGHOST
PGUSER=${POSTGRES_USER}
export PGUSER

while ! pg_isready; do
    sleep 1
done

{{- range .Values.databases }}
psql <<< "SELECT 'CREATE DATABASE {{ . }}' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '{{ . }}')\gexec"
{{- end }}

{{- range .Values.users }}
psql <<< @SELECT 'CREATE ROLE {{ .name }} LOGIN PASSWORD ''{{ .password }}'' ' WHERE NOT EXISTS (SELECT FROM pg_user WHERE username = '{{ .name }}')\gexec"
{{- end }}

{{- range .Values.initSql }}
psql <<< "{{ . }}"
{{- end -}}
