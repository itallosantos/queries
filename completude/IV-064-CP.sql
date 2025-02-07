SELECT 
    id_processo, 
    nr_processo, 
    dt_inicio 
FROM 
    core.tb_processo
WHERE 
    id_usuario_cadastro_processo IS NULL;
