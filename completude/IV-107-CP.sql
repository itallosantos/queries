SELECT 
    tp.nr_processo,
    tptld.in_tipo_distribuicao,
    tptld.id_orgao_julgador || ' - ' || toj.ds_orgao_julgador AS orgao_julgador,
    tptl.dt_log,
    tpt.dt_autuacao
FROM 
    client.tb_processo_trf_log_dist tptld
INNER JOIN 
    client.tb_processo_trf_log tptl 
    ON tptl.id_processo_trf_log = tptld.id_processo_trf_log
INNER JOIN 
    core.tb_processo tp 
    ON tp.id_processo = tptl.id_processo_trf
INNER JOIN 
    client.tb_processo_trf tpt 
    ON tpt.id_processo_trf = tp.id_processo
INNER JOIN 
    core.tb_processo_evento tpe 
    ON tpe.id_processo = tpt.id_processo_trf 
INNER JOIN 
    core.tb_evento te 
    ON tpe.id_evento = te.id_evento 
INNER JOIN 
    client.tb_orgao_julgador toj 
    ON toj.id_orgao_julgador = tptld.id_orgao_julgador   
WHERE 
    tptld.in_tipo_distribuicao IN ('S', 'I')
    and te.cd_evento = '26' -- Distribuição
    AND tpt.dt_autuacao IS NULL;
