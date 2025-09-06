{{
  config(
  materialized = "table",
  pre_hook = createGenAIModel('dbt_hackathon_shop','gemini_pro','gemini-2.0-flash')
  )
}}


SELECT
  ml_generate_text_result['candidates'][0]['content'] AS generated_text,
  * EXCEPT (ml_generate_text_result)
FROM
  ML.GENERATE_TEXT(
    MODEL `dbt_hackathon_shop.gemini_pro`,
    (
      SELECT
        CONCAT('Extract the key words from the text below: ', review) AS prompt,
        *
      FROM
        `bigquery-public-data.imdb.reviews`
      LIMIT 5
    ),
    STRUCT(
      0.2 AS temperature,
      100 AS max_output_tokens))  