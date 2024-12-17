USE revision;

SELECT DISTINCT(processor_brand) AS 'all_processor'
FROM smartphones;

SELECT DISTINCT brand_name,processor_brand
FROM smartphones;