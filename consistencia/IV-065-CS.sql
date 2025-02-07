SELECT 
    id_processo, 
    id_tipo_sit_processual, 
    ds_instancia, 
    dt_inicial, 
    dt_final
FROM 
    client.tb_situacao_processual
WHERE 
    dt_inicial > dt_final;