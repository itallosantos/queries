WITH primeira_distribuicao AS (
    SELECT 
        l.id_processo_trf,
        MIN(l.dt_log) AS dt_primeira_distribuicao
    FROM 
        client.tb_processo_trf_log l
    JOIN 
        client.tb_processo_trf_log_dist ld 
          ON l.id_processo_trf_log = ld.id_processo_trf_log
    GROUP BY 
        l.id_processo_trf
)
SELECT 
    pt.dt_autuacao,
    pd.dt_primeira_distribuicao AS dt_distribuicao,  -- Uso aqui a data da primeira distribuição
    tp.nr_processo,
    pt.id_processo_trf
FROM 
    client.tb_processo_trf pt
JOIN 
    core.tb_processo tp 
      ON pt.id_processo_trf = tp.id_processo
JOIN 
    primeira_distribuicao pd 
      ON pt.id_processo_trf = pd.id_processo_trf
WHERE 
    pt.dt_autuacao IS NOT NULL
    AND tp.nr_processo ~ '^0'
    AND pd.dt_primeira_distribuicao IS NOT NULL
    AND (pd.dt_primeira_distribuicao - pt.dt_autuacao) > INTERVAL '2 day'
ORDER BY 
    pt.dt_autuacao;