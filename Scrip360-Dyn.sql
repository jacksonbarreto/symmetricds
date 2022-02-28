-- CONFIGURAÇÃO DOS GRUPOS DE NÓS
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
    'DynamanWMS', 
    'IBS Dynaman WMS - SQL Server',
    current_timestamp, 
    current_timestamp,
    'Installation'
);

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
    'Sanitop360', 
    'Sanitop 360 - SQL Server',
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
    'DynamanWMS', 
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
    'DynamanWMS', 
    'W',
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
    'DynamanWMS-2-Sanitop360', 
    'DynamanWMS', 
    'Sanitop360', 
    current_timestamp, 
    current_timestamp,
    'Installation',
    'Router DynamanWMS to Sanitop360'
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
    'chanelDynaman', 
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
    'Dynaman WMS data chanel'
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
    'tablesDynaman',
    'task_detail,stock_product,picklist_detail_order,Container_Inventory,outbound_order_header,outbound_Order_Detail,inbound_Order_Header,arrival_detail,arrival_header,inbound_Order_detail,outbound_Order_text',
    'chanelDynaman', 
    current_timestamp, 
    current_timestamp,
    'Installation',
    'Dynaman WMS table mapping.'
);



-- CONFIGURAÇÃO DO ROTEAMENTO DOS TRIGGERS
-- Atenção ao initial_load_order: Posição numérica destas tabelas no carregamento inicial, enviada em ordem numérica crescente. 
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
    'tablesDynaman',
    'DynamanWMS-2-Sanitop360', 
    1, 
    current_timestamp, 
    current_timestamp,
    'Installation',
    'router for Dynaman WMS tables.'
);


--TRANSFORME
-- (altera o nome da tabela do WMS apra as do 360)

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
    'taskDetailChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'task_detail',
    'Dyn56_task_detail',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);


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
    'stockProductChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'stock_product',
    'Dyn56_stock_product',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);
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
    'picklistDetailOrderChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'picklist_detail_order',
    'Dyn56_picklist_detail_order',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);
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
    'outboundOrderDetailChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'outbound_Order_detail',
    'Dyn56_Outbound_order_Detail',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);
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
    'outboundOrderHeaderChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'outbound_order_header',
    'Dyn56_Outbound_order_header',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);
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
    'inboundOrderHeaderChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'inbound_Order_Header',
    'Dyn56_Inbound_order_Header',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);
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
    'arrivalDetailChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'arrival_detail',
    'Dyn56_Arrival_Detail',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);
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
    'arrivalHeaderChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'arrival_header',
    'Dyn56_Arrival_Header',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);
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
    'inboundOrderDetailChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'inbound_Order_detail',
    'Dyn56_Inbound_Order_Detail',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
);
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
    'outboundOrderTextChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'outbound_Order_text',
    'Dyn56_Outbound_Order_Text',
    'DEL_ROW',
    'UPD_ROW',
    'IMPLIED',
    current_timestamp,
    current_timestamp,
    'Installation',
    'Changes the name of the source table on the target.'
 );
 Container_Inventory
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
    'Container_InventoryChangeName',
    'DynamanWMS',
    'Sanitop360',
    'EXTRACT',
    'Container_Inventory',
    'Dyn56_Container_Inventory',
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
        'locationCodeContainerTransform', 
        '*', 
        'location_code', 
        'location_code', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'containerCodeContainerTransform', 
        '*', 
        'container_code', 
        'Container_code', 
        1,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'inventoryQtyContainerTransform', 
        '*', 
        'inventory_qty', 
        'inventory_qty', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'qtyOnPicklistContainerTransform', 
        '*', 
        'qty_on_picklist', 
        'qty_on_picklist', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'qtyNotOnPicklistContainerTransform', 
        '*', 
        'qty_not_on_picklist', 
        'qty_not_on_picklist', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'pickedQtyContainerTransform', 
        '*', 
        'picked_qty', 
        'picked_qty', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'handlingQtyContainerTransform', 
        '*', 
        'handling_qty', 
        'handling_qty', 
        0,
        'copy', 
        '', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'itemCodeContainerTransform', 
        '*', 
        'item_code', 
        '', 
        0,
        'lookup', 
        'SELECT item_code from stock_product WHERE stock_product_id = :stock_product_id', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'equipmentZoneCodeContainerTransform', 
        '*', 
        'equipment_zone_code', 
        '', 
        0,
        'lookup', 
        'SELECT equipment_zone_code from location WHERE warehouse_code = :warehouse_code AND location_code = :location_code', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);
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
        'stockTypeContainerTransform', 
        '*', 
        'StockType', 
        '', 
        0,
        'lookup', 
        'SELECT CASE WHEN Location_code IN ('1BRICO', 'OF', 'KITOF', 'BLISPACK', 'BLISPACKO', 'PINT', 'PVNOVA','PVNOVAO') THEN 'OF' WHEN Location_code IN ('LOST', 'UNDO') THEN 'LOST' WHEN Location_code LIKE ('GER%') THEN 'LOST' WHEN Location_code LIKE ('SGUR%') THEN 'LOST' WHEN Location_code LIKE ('AGUARD%') THEN 'WAIT' WHEN Location_code LIKE ('4CAIS%') THEN 'WAIT' WHEN Location_code IN ('01W0', '01W1', '02W0', '02W1', '02W2', '04W0', '04W1', '6P01W0', '06P02W0') THEN 'CAIS' WHEN Location_code IN ('04DOC01', '04DOC02', '04DOC03', '04DOC04', '04DOC05', '04DOCSOS', '01DOC01', '01DOC02', '01DOCNEI', '01DOCSAV') THEN 'CAIS' WHEN Location_code = '1REC01' THEN 'REC' WHEN Location_code LIKE ('1CAI%') THEN 'CAIS' ELSE 'STOCK' END AS StockType from location WHERE warehouse_code = :warehouse_code AND location_code = :location_code', 
        1, 
        current_timestamp, 
        'Installation',
        current_timestamp,
        'simple copy from source column to destination column.'
);