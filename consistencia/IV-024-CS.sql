WITH redistribuicoes_redundantes AS (SELECT ptr.id_processo_trf_redistribuicao,
                                            ptr.id_processo_trf,
                                            ptr.id_orgao_julgador,
                                            ptr.id_orgao_julgador_anterior,
                                            ptr.dt_redistribuicao,
                                            ptr.in_tipo_redistribuicao,
                                            ojc.ds_cargo
                                     FROM client.tb_proc_trf_redistribuicao ptr
                                              JOIN
                                          client.tb_orgao_julgador_cargo ojc
                                          ON
                                              ptr.id_orgao_julgador = ojc.id_orgao_julgador
                                                  OR ptr.id_orgao_julgador_anterior = ojc.id_orgao_julgador
                                     WHERE ptr.id_orgao_julgador = ptr.id_orgao_julgador_anterior),
     contagens AS (SELECT COUNT(*)                        AS total_redistribuicoes_redundantes,
                          COUNT(DISTINCT id_processo_trf) AS total_processos_unicos
                   FROM redistribuicoes_redundantes)
SELECT rr.*,
       c.total_redistribuicoes_redundantes,
       c.total_processos_unicos
FROM redistribuicoes_redundantes rr
         CROSS JOIN
     contagens c;