FROM grafana/grafana
COPY ./prov/datasources/default.yaml /etc/grafana/provisioning/datasources/default.yaml
COPY ./prov/datasources/csv.yaml /etc/grafana/provisioning/datasources/csv.yaml
COPY ./prov/datasources/ds-dev.yaml /etc/grafana/provisioning/datasources/ds-dev.yaml
COPY ./prov/dashboards/local.yaml /etc/grafana/provisioning/dashboards/local.yaml
COPY ./dashboard2.json /var/lib/grafana/dashboards/mydash.json
RUN grafana-cli --pluginUrl https://github.com/doitintl/bigquery-grafana/archive/2.0.2.zip plugins install doitintl-bigquery-datasource
RUN grafana-cli plugins install marcusolsson-csv-datasource
RUN grafana-cli admin reset-admin-password admin
#ENV GF_AUTH_DISABLE_LOGIN_FORM "true"
ENV GF_AUTH_ANONYMOUS_ENABLED "true"
# ENV GF_AUTH_ANONYMOUS_ORG_ROLE "Admin"
ENV GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS=doitintl-bigquery-datasource
