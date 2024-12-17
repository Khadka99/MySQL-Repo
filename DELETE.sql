USE revision;

SELECT * FROM smartphones
WHERE price > 200000;

DELETE FROM smartphones
WHERE price > 200000;

SELECT * FROM smartphones
WHERE primary_camera_rear > 150 AND brand_name = 'nokia';

DELETE FROM smartphones
WHERE primary_camera_rear > 150 AND brand_name = 'nokia';




