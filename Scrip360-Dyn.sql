-- CONFIGURAÇÃO DOS GRUPOS DE NÓS
INSERT INTO SYM_NODE_GROUP (node_group_id, description)
VALUES ('DynamanWMS', 'IBS Dynaman WMS - SQL Server');

INSERT INTO SYM_NODE_GROUP (node_group_id, description)
VALUES ('Sanitop360', 'Sanitop 360 - SQL Server');


-- CONFIGURAÇÃO DOS LINKS (CONEXÃO ENTRE GRUPOS)
-- verificar o data_event_action correto para cada link
INSERT INTO SYM_NODE_GROUP_LINK (source_node_group_id, target_node_group_id, data_event_action)
VALUES ('DynamanWMS', 'Sanitop360', 'P');

INSERT INTO SYM_NODE_GROUP_LINK (source_node_group_id, target_node_group_id, data_event_action)
VALUES ('Sanitop360', 'DynamanWMS', 'W');


-- CONFIGURAÇÃO DO ROTEAMENTO (talvez seja necessário configurar o Target Catalog e o Target Schema)
-- Target Table, deve ser definido no caso de o nome da tabela de destino ser diferente da de origem.
INSERT INTO SYM_ROUTER (router_id, source_node_group_id, target_node_group_id, create_time, last_update_time)
VALUES ('DynamanWMS-2-Sanitop360', 'DynamanWMS', 'Sanitop360', current_timestamp, current_timestamp);


-- CONFIGURAÇÃO DOS CANAIS 
insert into SYM_CHANNEL (channel_id, processing_order, max_batch_size, max_batch_to_send,
                         extract_period_millis, batch_algorithm, enabled, reload_flag, description, last_update_time, create_time)
values ('chanelDynaman', 2, 1000, 10, 0, 'default', 1, 1, 'Dynaman WMS data chanel', current_timestamp, current_timestamp);


-- CONFIGURAÇÃO DOS TRIGGERS (TABELAS A SEREM MONITORADAS)
----tabelas do Dynaman
INSERT INTO SYM_TRIGGER (trigger_id, source_table_name, channel_id, last_update_time, create_time)
VALUES ('tablesDynaman',
        'task_detail, outbound_order_header,  stock_product, picklist_detail_order, outbound_Order_Detail, inbound_Order_Header, Container_Inventory, arrival_detail, arrival_header, inbound_Order_detail, outbound_Order_text',
        'chanelDynaman', current_timestamp, current_timestamp);



-- CONFIGURAÇÃO DO ROTEAMENTO DOS TRIGGERS
-- Atenção ao initial_load_order: Posição numérica desta tabela no carregamento inicial, enviada em ordem numérica crescente. Quando dois valores numéricos são iguais, a ordem é baseada em restrições de chave estrangeira. Use um número negativo para excluir a tabela do carregamento inicial.
INSERT INTO SYM_TRIGGER_ROUTER (trigger_id, router_id, initial_load_order, create_time, last_update_time)
VALUES ('tablesDynaman', 'DynamanWMS-2-Sanitop360', 1, current_timestamp, current_timestamp);


--TRANSFORME
-- (altera o nome da tabela do WMS apra as do 360)

insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'taskDetailNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'task_detail',
        'Dyn56_task_detail',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'outboundOrderHeaderNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'outbound_order_header',
        'Dyn56_outbound_order_Header',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'stockProductNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'stock_product',
        'Dyn56_stock_product',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'picklistDetailOrderNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'picklist_detail_order',
        'Dyn56_picklist_detail_order',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'outboundOrderDetailNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'outbound_Order_detail',
        'Dyn56_Outbound_order_Detail',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'inboundOrderHeaderNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'inbound_Order_Header',
        'Dyn56_Inbound_order_Header',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'containerInventoryNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'Container_Inventory',
        'Dyn56_Container_Inventory',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'arrivalDetailNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'arrival_detail',
        'Dyn56_Arrival_Detail',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'arrivalHeaderNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'arrival_header',
        'Dyn56_Arrival_Header',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'inboundOrderDetailNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'inbound_Order_detail',
        'Dyn56_Inbound_Order_Detail',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );
    insert into sym_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name, target_table_name, delete_action, update_action, column_policy, create_time, last_update_time)
values (
        'outboundOrderTextNormalize',
        'DynamanWMS',
        'Sanitop360',
        'EXTRACT',
        'outbound_Order_text',
        'Dyn56_Outbound_Order_Text',
        'DEL_ROW',
        'UPD_ROW',
        'IMPLIED',
        current_timestamp,
        current_timestamp
    );