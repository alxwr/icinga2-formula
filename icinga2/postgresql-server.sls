{% from "icinga2/map.jinja" import icinga2 with context %}

{% if salt['pillar.get']('icinga2:postgres:use_formula', False) %}
include:
  - postgres.server
{% else %}
postgresql_for_icinga_web2:
   pkg.installed:
    - pkgs: {{ icinga2.icinga_web2.postgresql_pkgs | json }}
    - require_in:
      - postgres_user: icinga2web-db-setup
      - postgres_database: icinga2web-db-setup
   service.running:
    - name: {{ icinga2.icinga_web2.postgresql_service }}
    - require:
      - pkg: postgresql_for_icinga_web2
    - require_in:
      - postgres_user: icinga2web-db-setup
      - postgres_database: icinga2web-db-setup
{% endif %}
