
-- Удаляем все таблицы
DROP TABLE IF EXISTS scientist_groups CASCADE;
DROP TABLE IF EXISTS equipments CASCADE;
DROP TABLE IF EXISTS object_types CASCADE;
DROP TABLE IF EXISTS researchers CASCADE;
DROP TABLE IF EXISTS groups_ CASCADE;
DROP TABLE IF EXISTS scientist CASCADE;
DROP TABLE IF EXISTS organizations CASCADE;
DROP TABLE IF EXISTS territories CASCADE;

-- Территории 
CREATE TABLE territories (
    id SERIAL PRIMARY KEY,
    area INTEGER NOT NULL,
    type VARCHAR(255) NOT NULL
);

-- Организация
CREATE TABLE organizations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    finances BIGINT,
    address TEXT NOT NULL
);

-- Ученые
CREATE TABLE scientist (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthday_data DATA ITEGER NOT NULL,
    status VARCHAR(255),
);

-- Исследования
CREATE TABLE researchers (
    id SERIAL PRIMARY KEY,
    territory_id INTEGER NOT NULL REFERENCES territories(id),
    data DATE DEFAULT CURRENT_DATE
);

-- Группа
CREATE TABLE groups_ (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organizations(id),
    target TEXT NOT NULL,
    expected_result TEXT,
    research_id INTEGER UNIQUE REFERENCES researchers(id)
);

-- Оборудование
CREATE TABLE equipments (
    id SERIAL PRIMARY KEY,
    group_id INTEGER NOT NULL REFERENCES groups_(id),
    composition TEXT NOT NULL
);

-- Объекты исследования
CREATE TABLE object_types (
    id SERIAL PRIMARY KEY,  
    species_or_breed VARCHAR(255) NOT NULL,
    territory_id INTEGER NOT NULL REFERENCES territories(id)
);

-- Таблица многие-ко-многим
CREATE TABLE scientist_groups (
    group_id INTEGER NOT NULL REFERENCES groups_(id),
    scientist_id INTEGER NOT NULL REFERENCES scientist(id),
    CONSTRAINT group_membership_id PRIMARY KEY (group_id, scientist_id)
);
