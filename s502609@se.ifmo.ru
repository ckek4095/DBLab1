-- Сначала удаляем все таблицы (если существуют) в правильном порядке
DROP TABLE IF EXISTS scientist_groups CASCADE;
DROP TABLE IF EXISTS equipments CASCADE;
DROP TABLE IF EXISTS object_types CASCADE;
DROP TABLE IF EXISTS researchers CASCADE;
DROP TABLE IF EXISTS groups_ CASCADE;
DROP TABLE IF EXISTS scientist CASCADE;
DROP TABLE IF EXISTS organizations CASCADE;
DROP TABLE IF EXISTS territories CASCADE;

-- Территории (не зависит ни от кого)
CREATE TABLE territories (
    id SERIAL PRIMARY KEY,  -- автоинкремент
    area INTEGER NOT NULL,
    type VARCHAR(255) NOT NULL
);

-- Организация (не зависит ни от кого)
CREATE TABLE organizations (
    id SERIAL PRIMARY KEY,  -- автоинкремент
    name VARCHAR(255) NOT NULL,
    finances BIGINT,
    address TEXT NOT NULL
);

-- Ученые (не зависит ни от кого)
CREATE TABLE scientist (
    id SERIAL PRIMARY KEY,  -- автоинкремент
    name VARCHAR(255) NOT NULL,
    age INTEGER NOT NULL,
    status VARCHAR(255),
    expedition_experience INTEGER
);

-- Исследования (зависит от territories)
CREATE TABLE researchers (
    id SERIAL PRIMARY KEY,  -- автоинкремент
    territory_id INTEGER NOT NULL REFERENCES territories(id),
    data DATE DEFAULT CURRENT_DATE
);

-- Группа (зависит от organizations и researchers)
CREATE TABLE groups_ (
    id SERIAL PRIMARY KEY,  -- автоинкремент
    organization_id INTEGER NOT NULL REFERENCES organizations(id),
    target TEXT NOT NULL,
    expected_result TEXT,
    research_id INTEGER UNIQUE REFERENCES researchers(id)
);

-- Оборудование (зависит от groups_)
CREATE TABLE equipments (
    id SERIAL PRIMARY KEY,  -- автоинкремент
    group_id INTEGER NOT NULL REFERENCES groups_(id),
    composition TEXT NOT NULL
);

-- Объекты исследования (зависит от territories)
CREATE TABLE object_types (
    id SERIAL PRIMARY KEY,  -- автоинкремент
    species_or_breed VARCHAR(255) NOT NULL,
    territory_id INTEGER NOT NULL REFERENCES territories(id)
);

-- Таблица многие-ко-многим (зависит от groups_ и scientist)
CREATE TABLE scientist_groups (
    group_id INTEGER NOT NULL REFERENCES groups_(id),
    scientist_id INTEGER NOT NULL REFERENCES scientist(id),
    CONSTRAINT group_membership_id PRIMARY KEY (group_id, scientist_id)
);

-- Заполнение тестовыми данными (БЕЗ указания id - они проставятся автоматически)
INSERT INTO territories(area, type) VALUES (176, 'Лес');        -- id = 1
INSERT INTO territories(area, type) VALUES (152, 'Плато');      -- id = 2

INSERT INTO object_types(species_or_breed, territory_id) VALUES 
    ('мох обыкновенный', 2),     -- id = 1
    ('мох необыкновенный', 2),   -- id = 2
    ('дуб зеленый, златая цепь на дубе том', 1);  -- id = 3

INSERT INTO researchers(territory_id, data) VALUES (2, '2026-02-11');  -- id = 1

INSERT INTO organizations(name, finances, address) VALUES 
    ('Фирма Дяди Вовы', 520000000, 'ул Пушкина, д Колотушкина');  -- id = 1

INSERT INTO groups_(organization_id, target, expected_result, research_id) VALUES 
    (1, 'найти чо-нить прикольное', 'прикольчик 1, прикольчик 2, прикольчик 3', 1);  -- id = 1

INSERT INTO equipments(group_id, composition) VALUES 
    (1, 'ножнички, щипчики, лупа-пупа, компуктер');  -- id = 1

INSERT INTO scientist(name, age, status, expedition_experience) VALUES 
    ('Вася Пупкин', 52, 'Доцент', 5),     -- id = 1
    ('Иван Иванов', 67, 'Доктор наук', 28), -- id = 2
    ('Ашот Узбеков', 44, 'Шаурмист', 0);    -- id = 3

INSERT INTO scientist_groups(group_id, scientist_id) VALUES 
    (1, 1),  -- группа 1, Вася Пупкин
    (1, 2),  -- группа 1, Иван Иванов
    (1, 3);  -- группа 1, Ашот Узбеков