WITH ultimo_registro AS (SELECT distinct (st.id_processo),
                                         MAX(st.dt_inicial) AS ultimo
                         FROM client.tb_situacao_processual st
                                  JOIN
                              client.tb_complemento_segmentado cs
                              ON
                                  st.id_processo = cs.id_movimento_processo
                                  JOIN
                              client.tb_tipo_complemento tc
                              ON
                                  cs.id_tipo_complemento = tc.id_tipo_complemento
                         WHERE st.id_tipo_sit_processual = 14         -- Concluso
                           AND st.in_ativo = TRUE
                           AND st.dt_final IS NULL
                           AND tc.cd_tipo_complemento = '3'           -- tipo_de_conclusao
                           AND cs.ds_texto in ('5', '6', '36', '378') -- para despacho, decisao, julgamento e admissibilidade
                         GROUP BY st.id_processo)
SELECT tp.nr_processo
FROM client.tb_situacao_processual st
         JOIN core.tb_processo tp ON st.id_processo = tp.id_processo
         JOIN ultimo_registro ur ON st.id_processo = ur.id_processo AND st.dt_inicial = ur.ultimo
WHERE ur.ultimo <= NOW() - INTERVAL '50 days';
