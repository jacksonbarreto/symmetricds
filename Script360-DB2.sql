-- CONFIGURAÇÃO DOS NODOS
INSERT INTO SYM_NODE_GROUP 
(
    node_group_id, 
    description,
    create_time, 
    last_update_time,
    last_update_by
)
VALUES 
(
    'ERPDB2', 
    'ERP DB2 - IBM DB2',
    current_timestamp, 
    current_timestamp,
    'Installation'
);


-- CONFIGURAÇÃO DOS LINKS (CONEXÃO ENTRE GRUPOS)
-- verificar o data_event_action correto para cada link
INSERT INTO SYM_NODE_GROUP_LINK 
(
    source_node_group_id, 
    target_node_group_id, 
    data_event_action,
    create_time, 
    last_update_time,
    last_update_by
)
VALUES 
(
    'ERPDB2', 
    'Sanitop360', 
    'P',
    current_timestamp, 
    current_timestamp,
    'Installation'
);

INSERT INTO SYM_NODE_GROUP_LINK
(
    source_node_group_id, 
    target_node_group_id, 
    data_event_action,
    create_time, 
    last_update_time,
    last_update_by
)
VALUES 
(
    'Sanitop360', 
    'ERPDB2', 
    'P',
    current_timestamp, 
    current_timestamp,
    'Installation'
);

-- CONFIGURAÇÃO DO ROTEAMENTO (talvez seja necessário configurar o Target Catalog e o Target Schema)
-- Target Table, deve ser definido no caso de o nome da tabela de destino ser diferente da de origem.
INSERT INTO SYM_ROUTER 
(
    router_id, 
    source_node_group_id, 
    target_node_group_id, 
    create_time, 
    last_update_time,
    last_update_by,
    description
)
VALUES 
(
    'ERPDB2-2-Sanitop360', 
    'ERPDB2', 
    'Sanitop360', 
    current_timestamp, 
    current_timestamp,
    'Installation',
    'Router ERPDB2 to Sanitop360'
);

INSERT INTO SYM_ROUTER 
(
    router_id, 
    source_node_group_id, 
    target_node_group_id, 
    create_time, 
    last_update_time,
    last_update_by,
    description
)
VALUES 
(
    'Sanitop360-2-ERPDB2', 
    'Sanitop360', 
    'ERPDB2', 
    current_timestamp, 
    current_timestamp,
    'Installation',
    'Router Sanitop360 to ERPDB2'
);

-- CONFIGURAÇÃO DOS CANAIS 
INSERT INTO SYM_CHANNEL 
(
    channel_id, 
    processing_order, 
    max_batch_size, 
    max_batch_to_send,
    extract_period_millis, 
    batch_algorithm, 
    enabled, 
    reload_flag,     
    last_update_time, 
    create_time,
    last_update_by,
    description
)
VALUES 
(
    'chanelERPDB2', 
    2, 
    1000, 
    10, 
    0, 
    'default', 
    1, 
    1,     
    current_timestamp, 
    current_timestamp,
    'Installation',
    'ERPDB2 data chanel'
);

-- CONFIGURAÇÃO DOS TRIGGERS (TABELAS A SEREM MONITORADAS)
INSERT INTO SYM_TRIGGER 
(
    trigger_id, 
    source_table_name, 
    channel_id, 
    last_update_time, 
    create_time,
    last_update_by,
    description
)
VALUES 
(
    'tablesERPDB2',
    'MCODIG',
    'chanelERPDB2', 
    current_timestamp, 
    current_timestamp,
    'Installation',
    'ERPDB2 table mapping.'
);

-- CONFIGURAÇÃO DO ROTEAMENTO DOS TRIGGERS
-- Atenção ao initial_load_order: Posição numérica destas tabelas no carregamento inicial, 
-- enviada em ordem numérica crescente. 
-- Quando dois valores numéricos são iguais, a ordem é baseada em restrições de chave estrangeira. 
-- Use um número negativo para excluir a tabela do carregamento inicial.
INSERT INTO SYM_TRIGGER_ROUTER 
(
    trigger_id, 
    router_id, 
    initial_load_order, 
    create_time, 
    last_update_time, 
    last_update_by,
    description
)
VALUES 
(
    'tablesERPDB2',
    'ERPDB2-2-Sanitop360', 
    1, 
    current_timestamp, 
    current_timestamp,
    'Installation',
    'router for ERPDB2 tables.'
);


--TRANSFORME
-- (altera o nome da tabela do ERPDB2 para as do 360)

INSERT INTO sym_transform_table 
(
    transform_id, 
    source_node_group_id, 
    target_node_group_id, 
    transform_point, 
    source_table_name, 
    target_table_name, 
    delete_action, 
    update_action, 
    column_policy, 
    create_time, 
    last_update_time,
    last_update_by,
    description
)
VALUES 
(
    'MCODIG_ChangeName',
    'ERPDB2',
    'Sanitop360',
    'EXTRACT',
    'Container_Inventory',
    'TBProdutosPT',
    'DEL_ROW',
    'UPD_ROW',
    'SPECIFIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
 );


 --Transform Column
 INSERT INTO SYM_TRANSFORM_COLUMN 
 (
        transform_id, 
        include_on, 
        target_column_name, 
        source_column_name, 
        pk,
        transform_type, 
        transform_expression, 
        transform_order, 
        last_update_time,
        last_update_by, 
        create_time,
        description
) 
VALUES 
(
        'MCODIG_ChangeName', 
        '*', 
        'ccod', 
        'IDArtigo', 
        1,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
),
(
        'MCODIG_ChangeName', 
        '*', 
        'cdscr', 
        'DescricaoS2', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
),
(
        'MCODIG_ChangeName', 
        '*', 
        'cunid', 
        'UnidadeMEdidaVenda', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
),
(
        'MCODIG_ChangeName', 
        '*', 
        'cunpr', 
        'IDUnidadePreco', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
),
(
        'MCODIG_ChangeName', 
        '*', 
        'cetcm', 
        'IDFamilia', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
),
(
        'MCODIG_ChangeName', 
        '*', 
        'cpeso', 
        'Peso', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
),
(
        'MCODIG_ChangeName', 
        '*', 
        'cvol', 
        'Volume', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
),
(
        'MCODIG_ChangeName', 
        '*', 
        'cpvd1', 
        'PVP', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
),



