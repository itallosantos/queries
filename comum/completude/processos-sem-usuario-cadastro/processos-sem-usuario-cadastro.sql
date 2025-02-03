SELECT 
    id_processo, 
    nr_processo, 
    dt_inicio,
    dt_fim
FROM 
    core.tb_processo
WHERE
    id_usuario_cadastro_processo IS NULL;
