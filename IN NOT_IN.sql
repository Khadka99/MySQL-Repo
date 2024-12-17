USE revision;

SELECT * FROM smartphones
WHERE processor_brand = 'snapdragon' OR
processor_brand = 'exynos' OR
processor_brand = 'bionic';

SELECT * FROM smartphones
WHERE processor_brand IN ('snapdragon','exynos','bionic');

SELECT * FROM smartphones
WHERE processor_brand NOT IN ('snapdragon','exynos','bionic');

