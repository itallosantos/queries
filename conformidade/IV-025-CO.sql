WITH processos_eventos AS (
    SELECT 
        DISTINCT r.id_processo_trf,
        tp.*,
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM core.tb_processo_evento pe
                JOIN core.tb_evento e ON pe.id_evento = e.id_evento
                LEFT JOIN client.tb_complemento_segmentado tcs ON pe.id_processo_evento = tcs.id_movimento_processo
                LEFT JOIN client.tb_tipo_complemento ttc ON tcs.id_tipo_complemento = ttc.id_tipo_complemento
                WHERE pe.id_processo = r.id_processo_trf
                  AND e.cd_evento = '36' -- Redistribuicao
                  AND ttc.cd_tipo_complemento = '17' -- motivo_da_redistribuicao
            ) THEN 'com_evento_36_complemento_17'
            ELSE 'sem_evento_36_complemento_17'
        END AS categoria
    FROM 
        client.tb_proc_trf_redistribuicao r
   LEFT JOIN core.tb_processo tp on r.id_processo_trf = tp.id_processo
)
SELECT 
    categoria,
    COUNT(DISTINCT id_processo_trf) AS total_processos
FROM 
    processos_eventos
GROUP BY 
    categoria;

