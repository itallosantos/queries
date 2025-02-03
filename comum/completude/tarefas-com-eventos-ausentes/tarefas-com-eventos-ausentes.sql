SELECT
tp.nr_processo,
tpe.id_processo_evento,
tp.id_processo,
jt.create_,
jt.id_,
jt.name_
FROM
core.tb_processo tp
INNER JOIN
core.tb_processo_instance tpi ON tp.id_processo = tpi.id_processo
INNER JOIN
jbpm_taskinstance jt ON tpi.id_proc_inst = jt.procinst_
LEFT JOIN
core.tb_processo_evento tpe ON tpe.id_jbpm_task = jt.id_
WHERE 1=1
AND tpe.id_evento IS NULL
ORDER BY
jt.create_ ASC;
