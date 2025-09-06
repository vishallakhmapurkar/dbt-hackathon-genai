{% macro createGenAIModel(dataset, name, endpoint) -%}
  CREATE OR REPLACE MODEL `{{dataset}}.{{name}}`
    REMOTE WITH CONNECTION DEFAULT OPTIONS (ENDPOINT = '{{endpoint}}');
{%- endmacro %}