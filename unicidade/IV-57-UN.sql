SELECT 
    nr_processo, 
    COUNT(*) AS total
FROM 
    core.tb_processo
WHERE 
    nr_processo IS NOT NULL
GROUP BY 
    nr_processo
HAVING 
    COUNT(*) > 1;
