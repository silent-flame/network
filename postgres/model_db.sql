-- ============================================
-- DDL для PostgreSQL (адаптировано из HSQLDB)
-- ============================================

-- 1. AGENT_TYPES_RAW_LOG
CREATE TABLE agent_types_raw_log (
    id INTEGER NOT NULL,
    name VARCHAR(255),
    counter INTEGER NOT NULL,
    CONSTRAINT agent_types_raw_log_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX agent_types_raw_log_counter_uk ON agent_types_raw_log (counter);

-- 2. AL_CONFIGURATION
CREATE TABLE al_configuration (
    property_name VARCHAR(255) NOT NULL,
    property_value TEXT,
    CONSTRAINT al_configuration_pk PRIMARY KEY (property_name)
);

-- 3. AL_CUSTOM_TYPE
CREATE TABLE al_custom_type (
    table_name VARCHAR(255),
    column_name VARCHAR(255),
    type VARCHAR(255),
    name VARCHAR(255)
);

-- 4. AL_DB_OBJECTS
CREATE TABLE al_db_objects (
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255),
    usage VARCHAR(255),
    CONSTRAINT al_db_objects_pk PRIMARY KEY (name)
);

-- 5. AL_GROUPS
CREATE TABLE al_groups (
    group_name VARCHAR(255) NOT NULL,
    description TEXT,
    CONSTRAINT al_groups_pk PRIMARY KEY (group_name)
);

-- 6. AL_SELECTED_LOG_OBJECTS
CREATE TABLE al_selected_log_objects (
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255),
    CONSTRAINT al_selected_log_objects_pk PRIMARY KEY (name)
);

-- 7. AL_TABLES
CREATE TABLE al_tables (
    table_name VARCHAR(255) NOT NULL,
    group_name VARCHAR(255),
    description TEXT,
    CONSTRAINT al_tables_pk PRIMARY KEY (table_name)
);

-- 8. AL_VIEWS
CREATE TABLE al_views (
    view_name VARCHAR(255) NOT NULL,
    view_definition TEXT,
    is_valid BOOLEAN,
    CONSTRAINT al_views_pk PRIMARY KEY (view_name)
);

-- 9. AGENT_TYPE_ELEMENTS_RAW_LOG
CREATE TABLE agent_type_elements_raw_log (
    id INTEGER NOT NULL,
    agent_type_id INTEGER,
    name VARCHAR(255),
    counter INTEGER NOT NULL,
    CONSTRAINT agent_type_elements_raw_log_pk PRIMARY KEY (id),
    CONSTRAINT element_to_agent_type_ref FOREIGN KEY (agent_type_id)
        REFERENCES agent_types_raw_log(id)
);
CREATE INDEX element_to_agent_type_ref_idx ON agent_type_elements_raw_log (agent_type_id);
CREATE UNIQUE INDEX agent_type_elements_raw_log_counter_uk ON agent_type_elements_raw_log (counter);

-- 10. AGENT_TYPE_STATECHARTS_RAW_LOG
CREATE TABLE agent_type_statecharts_raw_log (
    statechart_id INTEGER,
    element_id INTEGER,
    counter INTEGER NOT NULL,
    CONSTRAINT statecharts_element_to_element_ref FOREIGN KEY (element_id)
        REFERENCES agent_type_elements_raw_log(id),
    CONSTRAINT statecharts_statechart_to_element_ref FOREIGN KEY (statechart_id)
        REFERENCES agent_type_elements_raw_log(id)
);
CREATE INDEX statecharts_element_to_element_ref_idx ON agent_type_statecharts_raw_log (element_id);
CREATE INDEX statecharts_statechart_to_element_ref_idx ON agent_type_statecharts_raw_log (statechart_id);
CREATE UNIQUE INDEX agent_type_statecharts_raw_log_counter_uk ON agent_type_statecharts_raw_log (counter);

-- 11. AGENTS_RAW_LOG
CREATE TABLE agents_raw_log (
    id INTEGER NOT NULL,
    agent_type_id INTEGER,
    name VARCHAR(255),
    date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT agents_raw_log_pk PRIMARY KEY (id),
    CONSTRAINT agent_type_ref FOREIGN KEY (agent_type_id)
        REFERENCES agent_types_raw_log(id)
);
CREATE INDEX agent_type_ref_idx ON agents_raw_log (agent_type_id);
CREATE UNIQUE INDEX agents_raw_log_counter_uk ON agents_raw_log (counter);

-- 12. DESTROYED_AGENTS_RAW_LOG
CREATE TABLE destroyed_agents_raw_log (
    agent_id INTEGER,
    date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT destroyed_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX destroyed_agent_ref_idx ON destroyed_agents_raw_log (agent_id);
CREATE UNIQUE INDEX destroyed_agents_raw_log_counter_uk ON destroyed_agents_raw_log (counter);

-- 13. EVENTS_RAW_LOG
CREATE TABLE events_raw_log (
    event_id INTEGER,
    date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT event_ref FOREIGN KEY (event_id)
        REFERENCES agent_type_elements_raw_log(id)
);
CREATE INDEX event_ref_idx ON events_raw_log (event_id);
CREATE UNIQUE INDEX events_raw_log_counter_uk ON events_raw_log (counter);

-- 14. FLOWCHART_ENTRIES_RAW_LOG
CREATE TABLE flowchart_entries_raw_log (
    counter INTEGER NOT NULL,
    agent_id INTEGER,
    block_id INTEGER,
    entry_date TIMESTAMP,
    CONSTRAINT flowchart_entries_block_agent_ref FOREIGN KEY (block_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT flowchart_entries_entity_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX flowchart_entries_block_agent_ref_idx ON flowchart_entries_raw_log (block_id);
CREATE INDEX flowchart_entries_entity_agent_ref_idx ON flowchart_entries_raw_log (agent_id);
CREATE UNIQUE INDEX flowchart_entries_raw_log_counter_uk ON flowchart_entries_raw_log (counter);

-- 15. FLOWCHART_PROCESS_STATES_RAW_LOG
CREATE TABLE flowchart_process_states_raw_log (
    agent_id INTEGER,
    block_id INTEGER,
    activity_type VARCHAR(20),
    start_date TIMESTAMP,
    stop_date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT flowchart_process_states_block_agent_ref FOREIGN KEY (block_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT flowchart_process_states_entity_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX flowchart_process_states_block_agent_ref_idx ON flowchart_process_states_raw_log (block_id);
CREATE INDEX flowchart_process_states_entity_agent_ref_idx ON flowchart_process_states_raw_log (agent_id);
CREATE UNIQUE INDEX flowchart_process_states_raw_log_counter_uk ON flowchart_process_states_raw_log (counter);

-- 20. RESOURCE_POOL_UTILIZATION_RAW_LOG
CREATE TABLE resource_pool_utilization_raw_log (
    pool_id INTEGER,
    utilization DOUBLE PRECISION,
    size INTEGER,
    counter INTEGER NOT NULL,
    CONSTRAINT resource_pool_utilization_pool_agent_ref FOREIGN KEY (pool_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX resource_pool_utilization_pool_agent_ref_idx ON resource_pool_utilization_raw_log (pool_id);
CREATE UNIQUE INDEX resource_pool_utilization_raw_log_counter_uk ON resource_pool_utilization_raw_log (counter);

-- 21. RESOURCE_UNIT_STATES_RAW_LOG
CREATE TABLE resource_unit_states_raw_log (
    unit_id INTEGER,
    pool_id INTEGER,
    usage_state VARCHAR(20),
    task_type VARCHAR(20),
    agent_id INTEGER,
    task_id INTEGER,
    start_date TIMESTAMP,
    stop_date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT resource_unit_states_agent_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT resource_unit_states_pool_agent_ref FOREIGN KEY (pool_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT resource_unit_states_task_agent_ref FOREIGN KEY (task_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT resource_unit_states_unit_agent_ref FOREIGN KEY (unit_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX resource_unit_states_agent_agent_ref_idx ON resource_unit_states_raw_log (agent_id);
CREATE INDEX resource_unit_states_pool_agent_ref_idx ON resource_unit_states_raw_log (pool_id);
CREATE INDEX resource_unit_states_task_agent_ref_idx ON resource_unit_states_raw_log (task_id);
CREATE INDEX resource_unit_states_unit_agent_ref_idx ON resource_unit_states_raw_log (unit_id);
CREATE UNIQUE INDEX resource_unit_states_raw_log_counter_uk ON resource_unit_states_raw_log (counter);

-- 22. RESOURCE_UNIT_UTILIZATION_RAW_LOG
CREATE TABLE resource_unit_utilization_raw_log (
    unit_id INTEGER,
    pool_id INTEGER,
    utilization DOUBLE PRECISION,
    counter INTEGER NOT NULL,
    CONSTRAINT resource_unit_utilization_pool_agent_ref FOREIGN KEY (pool_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT resource_unit_utilization_unit_agent_ref FOREIGN KEY (unit_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX resource_unit_utilization_pool_agent_ref_idx ON resource_unit_utilization_raw_log (pool_id);
CREATE INDEX resource_unit_utilization_unit_agent_ref_idx ON resource_unit_utilization_raw_log (unit_id);
CREATE UNIQUE INDEX resource_unit_utilization_raw_log_counter_uk ON resource_unit_utilization_raw_log (counter);

-- 23. STATECHART_STATES_RAW_LOG
CREATE TABLE statechart_states_raw_log (
    agent_id INTEGER,
    state_id INTEGER,
    entry_date TIMESTAMP,
    exit_date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT statechart_states_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT statechart_states_state_ref FOREIGN KEY (state_id)
        REFERENCES agent_type_elements_raw_log(id)
);
CREATE INDEX statechart_states_agent_ref_idx ON statechart_states_raw_log (agent_id);
CREATE INDEX statechart_states_state_ref_idx ON statechart_states_raw_log (state_id);
CREATE UNIQUE INDEX statechart_states_raw_log_counter_uk ON statechart_states_raw_log (counter);

-- 24. STATECHART_TRANSITIONS_RAW_LOG
CREATE TABLE statechart_transitions_raw_log (
    agent_id INTEGER,
    transition_id INTEGER,
    from_state_id INTEGER,
    date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT from_state_ref FOREIGN KEY (from_state_id)
        REFERENCES agent_type_elements_raw_log(id),
    CONSTRAINT statechart_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT transition_ref FOREIGN KEY (transition_id)
        REFERENCES agent_type_elements_raw_log(id)
);
CREATE INDEX from_state_ref_idx ON statechart_transitions_raw_log (from_state_id);
CREATE INDEX statechart_agent_ref_idx ON statechart_transitions_raw_log (agent_id);
CREATE UNIQUE INDEX statechart_transitions_raw_log_counter_uk ON statechart_transitions_raw_log (counter);
CREATE INDEX transition_ref_idx ON statechart_transitions_raw_log (transition_id);

-- 25. STATISTICS_RAW_LOG
CREATE TABLE statistics_raw_log (
    agent_id INTEGER,
    name VARCHAR(255),
    mean DOUBLE PRECISION,
    deviation DOUBLE PRECISION,
    minimum DOUBLE PRECISION,
    maximum DOUBLE PRECISION,
    mean_confidence DOUBLE PRECISION,
    number INTEGER,
    counter INTEGER NOT NULL,
    CONSTRAINT statistics_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX statistics_agent_ref_idx ON statistics_raw_log (agent_id);
CREATE UNIQUE INDEX statistics_raw_log_counter_uk ON statistics_raw_log (counter);

-- 26. TRACE_RAW_LOG
CREATE TABLE trace_raw_log (
    counter INTEGER NOT NULL,
    agent_id INTEGER,
    date TIMESTAMP,
    message_text TEXT,
    CONSTRAINT trace_log_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id)
);
CREATE UNIQUE INDEX trace_raw_log_counter_uk ON trace_raw_log (counter);
CREATE INDEX trace_log_agent_ref_idx ON trace_raw_log (agent_id);

-- 27. AGENT_ELEMENTS_RAW_LOG
CREATE TABLE agent_elements_raw_log (
    id INTEGER NOT NULL,
    agent_id INTEGER,
    name VARCHAR(255),
    counter INTEGER NOT NULL,
    CONSTRAINT agent_elements_raw_log_pk PRIMARY KEY (id),
    CONSTRAINT element_to_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX element_to_agent_ref_idx ON agent_elements_raw_log (agent_id);
CREATE UNIQUE INDEX agent_elements_raw_log_counter_uk ON agent_elements_raw_log (counter);

-- 28. AGENT_MESSAGES_RAW_LOG
CREATE TABLE agent_messages_raw_log (
    agent_id INTEGER,
    sender_id INTEGER,
    message TEXT,
    date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT messages_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id),
    CONSTRAINT messages_sender_agent_ref FOREIGN KEY (sender_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX messages_agent_ref_idx ON agent_messages_raw_log (agent_id);
CREATE INDEX messages_sender_agent_ref_idx ON agent_messages_raw_log (sender_id);
CREATE UNIQUE INDEX agent_messages_raw_log_counter_uk ON agent_messages_raw_log (counter);

-- 29. AGENT_MOVEMENT_RAW_LOG
CREATE TABLE agent_movement_raw_log (
    agent_id INTEGER,
    speed DOUBLE PRECISION,
    start_date TIMESTAMP,
    stop_date TIMESTAMP,
    counter INTEGER NOT NULL,
    CONSTRAINT movement_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX movement_agent_ref_idx ON agent_movement_raw_log (agent_id);
CREATE UNIQUE INDEX agent_movement_raw_log_counter_uk ON agent_movement_raw_log (counter);

-- 30. AGENT_PARAMETERS_RAW_LOG
CREATE TABLE agent_parameters_raw_log (
    agent_id INTEGER,
    parameter_name VARCHAR(255),
    parameter_value TEXT,
    counter INTEGER NOT NULL,
    CONSTRAINT agent_parameters_agent_ref FOREIGN KEY (agent_id)
        REFERENCES agents_raw_log(id)
);
CREATE INDEX agent_parameters_agent_ref_idx ON agent_parameters_raw_log (agent_id);
CREATE UNIQUE INDEX agent_parameters_raw_log_counter_uk ON agent_parameters_raw_log (counter);

-- 31. DATASETS_RAW_LOG
CREATE TABLE datasets_raw_log (
    element_id INTEGER,
    index INTEGER,
    x DOUBLE PRECISION,
    y DOUBLE PRECISION,
    counter INTEGER NOT NULL,
    CONSTRAINT datasets_element_ref FOREIGN KEY (element_id)
        REFERENCES agent_elements_raw_log(id)
);
CREATE INDEX datasets_element_ref_idx ON datasets_raw_log (element_id);
CREATE UNIQUE INDEX datasets_raw_log_counter_uk ON datasets_raw_log (counter);

-- 32. HISTOGRAMS_RAW_LOG
CREATE TABLE histograms_raw_log (
    element_id INTEGER,
    start DOUBLE PRECISION,
    "end" DOUBLE PRECISION,      -- <-- Ключевое слово в кавычках
    pdf DOUBLE PRECISION,
    cdf DOUBLE PRECISION,
    counter INTEGER NOT NULL,
    CONSTRAINT histograms_element_ref FOREIGN KEY (element_id)
        REFERENCES agent_elements_raw_log(id)
);
CREATE INDEX histograms_element_ref_idx ON histograms_raw_log (element_id);
CREATE UNIQUE INDEX histograms_raw_log_counter_uk ON histograms_raw_log (counter);
