USE revision;

/*
1. Create backup
2. Check number of rows
3. Check memory consumption for reference
4. Drop non important cols
5. Drop null values
6. Drop duplicates
7. Clean RAM -> change col data type
8. Clean weight -> change col type
9. ROUND price col and change to integer
10. Change the OpSys col
11. Gpu
12. Cpu
*/
SELECT * FROM laptops;
-- Creating Back up for dataset
		CREATE TABLE laptops_backup LIKE laptops;

		INSERT INTO laptops_backup
		SELECT * FROM laptops;

-- 2. Check number of rows        
SELECT COUNT(*) FROM laptops;
SELECT COUNT(*) FROM laptops_backup;

-- 3. Check memory consumption for reference
SELECT DATA_LENGTH/1024 AS 'KB' FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'revision'
AND TABLE_NAME = 'laptops';

-- 4. Drop non important cols?
ALTER TABLE laptops 
DROP COLUMN `Unnamed: 0`;

-- 5. Drop null values?
DELETE FROM laptops
WHERE `index` IN (SELECT `index` FROM laptops
WHERE Company IS NULL AND TypeName IS NULL AND Inches IS NULL 
AND ScreenResolution IS NULL AND Cpu IS NULL AND Ram IS NULL 
AND Memory IS NULL AND Gpu IS NULL AND OpSys IS NULL 
AND Weight IS NULL AND Price);

-- 6. Drop duplicates? -- 1272 - 43
SELECT Company, TypeName, Inches, ScreenResolution, Cpu, Ram, 
Memory, Gpu, OpSys, Weight, Price,COUNT(*)
FROM laptops
GROUP BY Company, TypeName, Inches, ScreenResolution, Cpu, Ram, 
Memory, Gpu, OpSys, Weight, Price
HAVING COUNT(*) > 1;

WITH cte_duplicates AS (
    SELECT Company, TypeName, Inches, ScreenResolution, Cpu, Ram, 
    Memory, Gpu, OpSys, Weight, Price
    FROM laptops
    GROUP BY Company, TypeName, Inches, ScreenResolution, Cpu, Ram,
    Memory, Gpu, OpSys, Weight, Price
    HAVING COUNT(*) > 1
)

DELETE FROM laptops
WHERE (Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price) IN (
    SELECT Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price
    FROM cte_duplicates
);

-- 7. Clean data-> change col data type?
SELECT DISTINCT(Weight) FROM laptops;

-- changed column data type.
ALTER TABLE laptops 
MODIFY COLUMN Inches DECIMAL(10,1);

-- repalced GB with nothing
UPDATE laptops
SET Ram = REPLACE(Ram,'GB','');

-- Type conversion
			ALTER TABLE laptops 
			MODIFY COLUMN Ram INTEGER;
			 
			-- Replace Weight 'kg' with nothing and type conversion
			SELECT Weight,REPLACE(Weight,'kg','')
			FROM laptops;

			UPDATE laptops
			SET Weight =REPLACE(Weight,'kg','');

			ALTER TABLE laptops 
			MODIFY COLUMN Weight DECIMAL(10,1);
-- Type conversion of Price to decimal
		SELECT Price,ROUND(Price) FROM laptops;
		UPDATE laptops
		SET Price = ROUND(Price);
		ALTER TABLE Laptops
		MODIFY COLUMN Price INTEGER;
        
      
/* 
 **cleaning column OpSys** 
macOS    - macos
No OS     - windows
Windows 10 - linux
Mac OS X   - no os
Linux      - android chrome(others)
Windows 10 S
Chrome OS
Windows 7
Android
*/

SELECT OpSys ,
CASE
	WHEN OpSys LIKE '%mac%' THEN 'macos'
    WHEN OpSys LIKE '%windows%' THEN 'windows'
    WHEN OpSys LIKE '%linux%' THEN 'linux'
    WHEN OpSys LIKE '%no os%' THEN 'N/A'
    ELSE 'other'
END AS 'Os_Brand'
FROM laptops;

UPDATE laptops
SET OpSys = CASE
				WHEN OpSys LIKE '%mac%' THEN 'macos'
				WHEN OpSys LIKE '%windows%' THEN 'windows'
				WHEN OpSys LIKE '%linux%' THEN 'linux'
				WHEN OpSys LIKE '%no os%' THEN 'N/A'
				ELSE 'other'
			END;
-- Create 2 new columns and split column Gpu in to two new columns.
			ALTER TABLE laptops
			ADD COLUMN Gpu_brand VARCHAR(255) AFTER Gpu,
			ADD COLUMN Gpu_name VARCHAR(255) AFTER Gpu_brand;

			SELECT Gpu,SUBSTRING_INDEX(Gpu,' ',1),Gpu_brand FROM laptops;
			UPDATE laptops
			SET Gpu_brand = SUBSTRING_INDEX(Gpu,' ',1);

			SELECT Gpu,REPLACE(Gpu,Gpu_brand,'') FROM laptops;

			UPDATE laptops
			SET Gpu_name = REPLACE(Gpu,Gpu_brand,'');

			SELECT Gpu,Gpu_brand,Gpu_name FROM laptops;
			SELECT * FROM laptops;
			ALTER TABLE laptops
			DROP COLUMN Gpu;
            
SELECT * FROM laptops;

-- Create 3 new columns and split column Cpu in to 3 new columns.
ALTER TABLE laptops
			ADD COLUMN Cpu_brand VARCHAR(255) AFTER Cpu,
			ADD COLUMN Cpu_name VARCHAR(255) AFTER Cpu_brand,
            ADD COLUMN Cpu_speed DECIMAL(10,1) AFTER Cpu_name;

SELECT Cpu,SUBSTRING_INDEX(Cpu,' ',1) FROM laptops;
-- Cpu_brand
UPDATE laptops
SET Cpu_brand = SUBSTRING_INDEX(Cpu,' ',1);

SELECT Cpu,CAST(REPLACE(SUBSTRING_INDEX(Cpu,' ',-1),'GHz','') AS DECIMAL(10,2))
 FROM laptops;
 
 UPDATE laptops
SET Cpu_speed = CAST(REPLACE(SUBSTRING_INDEX(Cpu,' ',-1),'GHz','') AS DECIMAL(10,2));

SELECT Cpu,REPLACE(REPLACE(Cpu,Cpu_brand,""),SUBSTRING_INDEX(REPLACE(Cpu,Cpu_brand,""),' ',-1),''),
REPLACE(Cpu,Cpu_brand,""),
SUBSTRING_INDEX(REPLACE(Cpu,Cpu_brand,""),' ',-1)
FROM laptops;

UPDATE laptops
SET Cpu_name = REPLACE(REPLACE(Cpu,Cpu_brand,""),SUBSTRING_INDEX(REPLACE(Cpu,Cpu_brand,""),' ',-1),'');

SELECT Cpu_name,SUBSTRING_INDEX(TRIM(Cpu_name),' ',2) 
FROM laptops;

UPDATE laptops
SET Cpu_name = SUBSTRING_INDEX(TRIM(Cpu_name),' ',2);

ALTER TABLE laptops
DROP COLUMN Cpu;

-- ScreenResolution
SELECT ScreenResolution,
SUBSTRING_INDEX(ScreenResolution,' ',-1), 
SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),'x',1),
SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),'x',-1)FROM laptops;
-- Divide ScreenResolution Column in to 3 columns
ALTER TABLE laptops
ADD COLUMN Resolution_width INTEGER AFTER ScreenResolution,
ADD COLUMN Resolution_height INTEGER AFTER Resolution_width;

UPDATE laptops
SET Resolution_width = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),'x',1),
    Resolution_height = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),'x',-1);
    
ALTER TABLE laptops
ADD COLUMN TouchScreen INTEGER AFTER Resolution_height;

UPDATE laptops
SET TouchScreen = ScreenResolution LIKE '%Touch%';

ALTER TABLE laptops
DROP COLUMN ScreenResolution;

-- Memory

ALTER TABLE laptops
ADD COLUMN Memory_Type VARCHAR(255) AFTER Memory,
ADD COLUMN Primary_Storage INTEGER AFTER Memory_Type,
ADD COLUMN secondary_Storage INTEGER AFTER Primary_Storage;

SELECT Memory,
CASE
		WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
        WHEN Memory LIKE '%SSD%' THEN 'SSD'
        WHEN Memory LIKE '%HDD%' THEN 'HDD'
        WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
        WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
        WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
        ELSE NULL
END AS 'Memory_Type'
FROM laptops;

SELECT Memory,REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+'),
CASE
	WHEN Memory LIKE '%+%' THEN REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,' + ',-1),'[0-9]+') ELSE 0 END 
    FROM laptops;

-- Updating Memory column......
UPDATE laptops
SET Memory_Type = CASE
						WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
						WHEN Memory LIKE '%SSD%' THEN 'SSD'
						WHEN Memory LIKE '%HDD%' THEN 'HDD'
						WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
						WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
						WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
						ELSE NULL
					END,
	Primary_Storage = REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+'),
    secondary_Storage = CASE
							WHEN Memory LIKE '%+%' THEN 
                            REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,' + ',-1),'[0-9]+') ELSE 0 END;
SELECT Primary_Storage,
CASE
	WHEN Primary_Storage <= 2 THEN Primary_Storage*1024 ELSE Primary_Storage END,
secondary_Storage,
CASE
	WHEN secondary_Storage <= 2 THEN secondary_Storage*1024 ELSE secondary_Storage END
FROM laptops;

-- Again update Memory converting TB to GB by Multiplying 1024
UPDATE laptops
SET Primary_Storage = CASE
					  WHEN Primary_Storage <= 2 
                      THEN Primary_Storage*1024 ELSE Primary_Storage END,
	secondary_Storage = CASE
					   WHEN secondary_Storage <= 2 
                       THEN secondary_Storage*1024 ELSE secondary_Storage END;
 -- Droping Column memory                      
ALTER TABLE laptops
DROP COLUMN Memory;
-- Also Droping Column Gpu_name
ALTER TABLE laptops
DROP COLUMN Gpu_name;

ALTER TABLE laptops
ADD COLUMN Pixels_Per_Inch DECIMAL(10,2) AFTER Inches;


SELECT ROUND(SQRT(POW(Resolution_width, 2) + POW(Resolution_height, 2)) / Inches,2) AS PPI
FROM laptops;

UPDATE laptops
SET Pixels_Per_Inch = ROUND(SQRT(POW(Resolution_width, 2) + POW(Resolution_height, 2)) / Inches,2);

SELECT * FROM laptops;                      































































































































































































































































































