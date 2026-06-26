-- ============================================
-- 1. СОЗДАНИЕ СХЕМЫ CONFIG
-- ============================================

CREATE SCHEMA IF NOT EXISTS config;

SET search_path TO config, public;

-- ============================================
-- 2. ТАБЛИЦА: abonents (Параметры абонентов)
-- ============================================

CREATE TABLE config.abonents (
    id SERIAL PRIMARY KEY,
    abonent_type VARCHAR(50) NOT NULL,
    kol_abonent INTEGER NOT NULL,
    time_abonent DOUBLE PRECISION NOT NULL,
    kol_prog INTEGER NOT NULL,
    num_abonent INTEGER NOT NULL UNIQUE,
    emk_bufer_vx INTEGER NOT NULL,
    ver_kat_1 DOUBLE PRECISION NOT NULL,
    ver_kat_2 DOUBLE PRECISION NOT NULL,
    ver_kat_3 DOUBLE PRECISION NOT NULL,
    ver_kat_4 DOUBLE PRECISION NOT NULL,
    dl_kat_1 INTEGER NOT NULL,
    dl_kat_2 INTEGER NOT NULL,
    dl_kat_3 INTEGER NOT NULL,
    dl_kat_4 INTEGER NOT NULL,
    dl_kat_o_1 INTEGER NOT NULL,
    dl_kat_o_2 INTEGER NOT NULL,
    dl_kat_o_3 INTEGER NOT NULL,
    dl_kat_o_4 INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);


COMMENT ON TABLE config.abonents IS 'Параметры абонентов';
COMMENT ON COLUMN config.abonents.id IS 'Уникальный идентификатор';
COMMENT ON COLUMN config.abonents.abonent_type IS 'Тип абонента (Абонент1, Абонент2, ...)';
COMMENT ON COLUMN config.abonents.kol_abonent IS 'Общее количество абонентов в сети';
COMMENT ON COLUMN config.abonents.time_abonent IS 'Интервал времени между созданием сообщений';
COMMENT ON COLUMN config.abonents.kol_prog IS 'Количество прогонов модели';
COMMENT ON COLUMN config.abonents.num_abonent IS 'Номер абонента (1-6)';
COMMENT ON COLUMN config.abonents.emk_bufer_vx IS 'Емкость входного буфера абонента';
COMMENT ON COLUMN config.abonents.ver_kat_1 IS 'Вероятность категории 1';
COMMENT ON COLUMN config.abonents.ver_kat_2 IS 'Вероятность категории 2';
COMMENT ON COLUMN config.abonents.ver_kat_3 IS 'Вероятность категории 3';
COMMENT ON COLUMN config.abonents.ver_kat_4 IS 'Вероятность категории 4';
COMMENT ON COLUMN config.abonents.dl_kat_1 IS 'Длина сообщения для категории 1';
COMMENT ON COLUMN config.abonents.dl_kat_2 IS 'Длина сообщения для категории 2';
COMMENT ON COLUMN config.abonents.dl_kat_3 IS 'Длина сообщения для категории 3';
COMMENT ON COLUMN config.abonents.dl_kat_4 IS 'Длина сообщения для категории 4';
COMMENT ON COLUMN config.abonents.dl_kat_o_1 IS 'Среднеквадратичное отклонение длины для категории 1';
COMMENT ON COLUMN config.abonents.dl_kat_o_2 IS 'Среднеквадратичное отклонение длины для категории 2';
COMMENT ON COLUMN config.abonents.dl_kat_o_3 IS 'Среднеквадратичное отклонение длины для категории 3';
COMMENT ON COLUMN config.abonents.dl_kat_o_4 IS 'Среднеквадратичное отклонение длины для категории 4';
COMMENT ON COLUMN config.abonents.created_at IS 'Дата и время создания записи';
COMMENT ON COLUMN config.abonents.updated_at IS 'Дата и время последнего обновления записи';


-- ============================================
-- 3. ТАБЛИЦА: channels (Параметры каналов)
-- ============================================

CREATE TABLE config.channels (
    id SERIAL PRIMARY KEY,
    channel_id VARCHAR(30) NOT NULL UNIQUE,
    channel_name VARCHAR(50),
    stor_pered_kan DOUBLE PRECISION NOT NULL,
    stor_pered_kan_r DOUBLE PRECISION NOT NULL,
    time_otk_kan DOUBLE PRECISION NOT NULL,
    time_vosst_kan DOUBLE PRECISION NOT NULL,
    time_bkl_res_k DOUBLE PRECISION NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE config.channels IS 'Параметры каналов';
COMMENT ON COLUMN config.channels.channel_id IS 'Идентификатор канала (канал1, канал2, ...)';
COMMENT ON COLUMN config.channels.stor_pered_kan IS 'Скорость передачи основного канала';
COMMENT ON COLUMN config.channels.stor_pered_kan_r IS 'Скорость передачи резервного канала';
COMMENT ON COLUMN config.channels.time_otk_kan IS 'Время отказа канала';
COMMENT ON COLUMN config.channels.time_vosst_kan IS 'Время восстановления канала';
COMMENT ON COLUMN config.channels.time_bkl_res_k IS 'Время переключения на резерв';

-- ============================================
-- 4. ТАБЛИЦА: routers (Параметры маршрутизаторов)
-- ============================================

CREATE TABLE config.routers (
    id SERIAL PRIMARY KEY,
    router_id VARCHAR(30) NOT NULL UNIQUE,
    router_name VARCHAR(50),
    emk_bufer_napr1 INTEGER NOT NULL,
    emk_bufer_napr2 INTEGER NOT NULL,
    emk_bufer_napr3 INTEGER NOT NULL,
    emk_bufer_napr4 INTEGER NOT NULL,
    emk_bufer1 INTEGER NOT NULL,
    time_otk_bk DOUBLE PRECISION NOT NULL,
    time_vosst_bk DOUBLE PRECISION NOT NULL,
    proizvod DOUBLE PRECISION NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE config.routers IS 'Параметры маршрутизаторов';
COMMENT ON COLUMN config.routers.id IS 'Уникальный идентификатор';
COMMENT ON COLUMN config.routers.router_id IS 'Идентификатор маршрутизатора (маршрут1, маршрут2)';
COMMENT ON COLUMN config.routers.router_name IS 'Наименование маршрутизатора';
COMMENT ON COLUMN config.routers.emk_bufer_napr1 IS 'Емкость буфера направления 1 (байт)';
COMMENT ON COLUMN config.routers.emk_bufer_napr2 IS 'Емкость буфера направления 2 (байт)';
COMMENT ON COLUMN config.routers.emk_bufer_napr3 IS 'Емкость буфера направления 3 (байт)';
COMMENT ON COLUMN config.routers.emk_bufer_napr4 IS 'Емкость буфера направления 4 (байт)';
COMMENT ON COLUMN config.routers.emk_bufer1 IS 'Емкость общего буфера маршрутизатора (байт)';
COMMENT ON COLUMN config.routers.time_otk_bk IS 'Среднее время до отказа вычислительного комплекса (сек)';
COMMENT ON COLUMN config.routers.time_vosst_bk IS 'Среднее время восстановления вычислительного комплекса (сек)';
COMMENT ON COLUMN config.routers.proizvod IS 'Производительность обработки сообщений (байт/сек)';
COMMENT ON COLUMN config.routers.created_at IS 'Дата и время создания записи';
COMMENT ON COLUMN config.routers.updated_at IS 'Дата и время последнего обновления записи';


-- ============================================
-- 5. ИНДЕКСЫ
-- ============================================

CREATE INDEX idx_abonents_num_abonent ON config.abonents(num_abonent);
CREATE INDEX idx_channels_channel_id ON config.channels(channel_id);
CREATE INDEX idx_routers_router_id ON config.routers(router_id);

-- ============================================
-- 6. НАЧАЛЬНЫЕ ДАННЫЕ (INSERT)
-- ============================================

-- Абоненты (6 штук)
INSERT INTO config.abonents (
    abonent_type, kol_abonent, time_abonent, kol_prog, num_abonent,
    emk_bufer_vx, ver_kat_1, ver_kat_2, ver_kat_3, ver_kat_4,
    dl_kat_1, dl_kat_2, dl_kat_3, dl_kat_4,
    dl_kat_o_1, dl_kat_o_2, dl_kat_o_3, dl_kat_o_4
) VALUES
('Абонент1', 6, 30, 100, 1, 80000, 0.3, 0.5, 0.7, 1.0, 53000, 86000, 66000, 50000, 6100, 5000, 7000, 500),
('Абонент2', 6, 30, 100, 2, 80000, 0.3, 0.5, 0.7, 1.0, 53000, 86000, 66000, 50000, 6100, 5000, 7000, 500),
('Абонент3', 6, 30, 100, 3, 80000, 0.3, 0.5, 0.7, 1.0, 53000, 86000, 66000, 50000, 6100, 5000, 7000, 500),
('Абонент4', 6, 30, 100, 4, 80000, 0.3, 0.5, 0.7, 1.0, 53000, 86000, 66000, 50000, 6100, 5000, 7000, 500),
('Абонент5', 6, 30, 100, 5, 80000, 0.3, 0.5, 0.7, 1.0, 53000, 86000, 66000, 50000, 6100, 5000, 7000, 500),
('Абонент6', 6, 30, 100, 6, 80000, 0.3, 0.5, 0.7, 1.0, 53000, 86000, 66000, 50000, 6100, 5000, 7000, 500);

-- Каналы (12 штук)
INSERT INTO config.channels (
    channel_id, channel_name, stor_pered_kan, stor_pered_kan_r,
    time_otk_kan, time_vosst_kan, time_bkl_res_k
) VALUES
('канал1', 'Канал 1', 5000, 5000, 360, 3.2, 0.1),
('канал2', 'Канал 2', 5000, 5000, 360, 3.2, 0.1),
('канал3', 'Канал 3', 5000, 5000, 360, 3.2, 0.1),
('канал4', 'Канал 4', 5000, 5000, 360, 3.2, 0.1),
('канал5', 'Канал 5', 5000, 5000, 360, 3.2, 0.1),
('канал6', 'Канал 6', 5000, 5000, 360, 3.2, 0.1),
('канал7', 'Канал 7', 5000, 5000, 360, 3.2, 0.1),
('канал8', 'Канал 8', 5000, 5000, 360, 3.2, 0.1),
('канал9', 'Канал 9', 5000, 5000, 360, 3.2, 0.1),
('канал10', 'Канал 10', 5000, 5000, 360, 3.2, 0.1),
('канал11', 'Канал 11', 5000, 5000, 360, 3.2, 0.1),
('канал12', 'Канал 12', 5000, 5000, 360, 3.2, 0.1);

-- Маршрутизаторы (2 штуки)
INSERT INTO config.routers (
    router_id, router_name, emk_bufer_napr1, emk_bufer_napr2,
    emk_bufer_napr3, emk_bufer_napr4, emk_bufer1,
    time_otk_bk, time_vosst_bk, proizvod
) VALUES
('маршрут1', 'Маршрутизатор 1', 250000, 250000, 250000, 250000, 5000000, 3600, 3.7, 40000),
('маршрут2', 'Маршрутизатор 2', 250000, 250000, 250000, 250000, 5000000, 3600, 3.7, 40000);

-- ============================================
-- 7. ФУНКЦИЯ ДЛЯ ОБНОВЛЕНИЯ TIMESTAMP
-- ============================================

CREATE OR REPLACE FUNCTION config.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггеры
CREATE TRIGGER trigger_abonents_updated_at
    BEFORE UPDATE ON config.abonents
    FOR EACH ROW
    EXECUTE FUNCTION config.update_updated_at_column();

CREATE TRIGGER trigger_channels_updated_at
    BEFORE UPDATE ON config.channels
    FOR EACH ROW
    EXECUTE FUNCTION config.update_updated_at_column();

CREATE TRIGGER trigger_routers_updated_at
    BEFORE UPDATE ON config.routers
    FOR EACH ROW
    EXECUTE FUNCTION config.update_updated_at_column();
