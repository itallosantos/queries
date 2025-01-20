SELECT
    json_build_object(
            'nr_processo', p.nr_processo,
            'dt_distribuicao', tpt.dt_distribuicao
    )
FROM client.tb_processo_trf tpt
JOIN core.tb_processo p on tpt.id_processo_trf = p.id_processo
where p.nr_processo is not null and dt_distribuicao is not null limit 100;
