WITH CTE AS
(
SELECT  
LOAD_DATE, BATCHID,AGEAS_KEY,Load_Type,Ageas_Policy,Product,Cover_Type, Risk_id,
convert(integer, CONVERT(VARCHAR,CONVERT(date, SUBSTRING(LOAD_DATE,1,10), 101),112)) new_date
--COUNT(*) OVER (PARTITION BY Load_Type,Ageas_Policy,Product ,Cover_Type,Risk_Id) CNT
FROM Ageas_Digital_Premium
where Load_Type= 'L'
)
,CTE2 AS (
SELECT
*, ROW_NUMBER() OVER (PARTITION BY Load_Type,Ageas_Policy,Product,Cover_Type, Risk_id  ORDER BY new_date DESC) RNUM
FROM CTE
)
SELECT * FROM CTE2 where rnum > 1;