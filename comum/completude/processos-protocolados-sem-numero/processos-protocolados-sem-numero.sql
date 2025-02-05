SELECT p.id_processo
FROM core.tb_processo p
         JOIN core.tb_processo_instance tpi ON p.id_processo = tpi.id_processo
         JOIN public.jbpm_processinstance jpi ON tpi.id_proc_inst = jpi.id_
         JOIN public.jbpm_processdefinition jp ON jpi.processdefinition_ = jp.id_
WHERE p.nr_processo IS NULL;