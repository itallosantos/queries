WITH retorna_arquivados AS (
    SELECT
        jt.actorid_,
        jt.create_,
        tpi.id_processo,
        jt.id_
    FROM
        core.tb_processo_instance tpi
    JOIN jbpm_taskinstance jt ON jt.procinst_ = tpi.id_proc_inst
    JOIN core.tb_tarefa t ON jt.name_ = t.ds_tarefa
    WHERE
        t.ds_tarefa ILIKE '%Arquiv%'
        AND jt.end_ IS NULL
)
SELECT
    pe.nr_processo
FROM
    core.tb_processo_evento pe
JOIN core.tb_evento ev ON pe.id_evento = ev.id_evento
JOIN core.tb_processo p ON pe.id_processo = p.id_processo
WHERE
    pe.id_processo IN (
        SELECT id_processo
        FROM retorna_arquivados
    )
    AND ev.cd_evento NOT IN ('246', '22', '245', '14997', '14998');
