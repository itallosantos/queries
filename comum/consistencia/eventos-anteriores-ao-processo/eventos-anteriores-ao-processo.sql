SELECT 
    pe.id_processo, 
    pe.dt_atualizacao AS data_evento, 
    p.dt_inicio AS data_inicio_processo
FROM 
    core.tb_processo_evento pe
JOIN 
    core.tb_processo p ON pe.id_processo = p.id_processo
WHERE 
    pe.dt_atualizacao < p.dt_inicio
ORDER BY p.dt_inicio ASC, pe.dt_atualizacao ASC;
