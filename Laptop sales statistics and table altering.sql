ALTER TABLE `laptop sales per day` ADD COLUMN Units_Sold3 INT;
UPDATE `laptop sales per day`
SET Units_Sold3 = `Total Sales per Day (euros)` / `Price_euros`

-- pearson correlation
SELECT
    (AVG(`Units_Sold` * `Total Sales per Day (euros)`) - AVG(`Units_Sold`) * AVG(`Total Sales per Day (euros)`)) /
    (STDDEV(`Units_Sold`) * STDDEV(`Total Sales per Day (euros)`)) AS correlation
FROM `laptop sales per day`;

-- convert column to string
ALTER TABLE `laptop sales per day` MODIFY COLUMN `Ram (GB)` VARCHAR(255);
UPDATE `laptop sales per day` SET `Ram (GB)` = CAST( `Ram (GB)` AS CHAR);

-- convert ot number
ALTER TABLE `laptop sales per day` MODIFY COLUMN `Price_euros` INT;
UPDATE `laptop sales per day` SET `Price_euros` = CAST( `Price_euros` AS CHAR)

ALTER TABLE `laptop sales per day` MODIFY COLUMN `Total Sales per Day (euros)` INT;
UPDATE `laptop sales per day` SET `Total Sales per Day (euros)` = CAST( `Total Sales per Day (euros)` AS CHAR)

-- calculating mean
SELECT
    'Windows 10' as OpSys,
    AVG(`Total Sales per Day (euros)`) as mean_sales
FROM `laptop sales per day`
WHERE OpSys = 'Windows 10'
UNION ALL
SELECT
    'Windows 7' as OpSys,
    AVG(`Total Sales per Day (euros)`) as mean_sales
FROM `laptop sales per day`
WHERE OpSys = 'Windows 7';

-- cohen d
SELECT
    (avg_win10 - avg_Win7) /
    SQRT(((count_win10-1)*var_Win10 + (count_Win7-1)*var_win7) / (count_win10 + count_win7 - 2)) as cohebs_d
FROM (
    SELECT
        AVG(CASE WHEN OpSys = 'Windows 10' Then `Total Sales per Day (euros)` END) as avg_win10,
        AVG(CASE WHEN OpSys = 'Windows 7' Then `Total Sales per Day (euros)` END) as avg_win7,
        COUNT(CASE WHEN OpSys = 'Windows 10' THEN 1 END) as count_win10,
        COUNT(CASE WHEN OpSys = 'Windows 7' THEN 1 END) as count_win7,
        VARIANCE(CASE WHEN OpSys = "Windows 10" THEN `Total Sales per Day (euros)` END) as var_win10,
        VARIANCE(CASE WHEN OpSys = "Windows 7" THEN `Total Sales per Day (euros)` END) as var_win7
	FROM `laptop sales per day`
) as stats;

-- variance

SELECT
    'Windows 10' as OpSys,
    VARIANCE(`Total Sales per Day (euros)`) as variance
FROM `laptop sales per day`
WHERE OpSys = 'Windows 10'
UNION ALL
SELECT
    'Windows 7' as OpSys,
    VARIANCE(`Total Sales per Day (euros)`) as variance
FROM `laptop sales per day`
WHERE OpSys = 'Windows 7';

-- filter data
SET SQL_SAFE_UPDATES = 0;
DELETE FROM `laptop sales per day`
WHERE OpSys = 'Windows 10' AND `Total Sales per Day (euros)` > 6000;
-- make a column that keep the brand of the intel name only
SELECT Cpu
FROM `laptop sales per day`;
--
UPDATE `laptop sales per day`
SET CPU = SUBSTRING_INDEX(CPU, ' ', 1);
--
SELECT Cpu
FROM `laptop sales per day`;