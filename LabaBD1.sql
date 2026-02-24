BEGIN;

-- Организация
CREATE TABLE organizations (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    finances BIGINT,
    address TEXT NOT NULL
);

-- Группа
CREATE TABLE groups (
    id INTEGER PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organizations(id),
    target TEXT NOT NULL,
    expected_result TEXT,
    research_id INTEGER UNIQUE REFERENCES researchers(id)
);

-- Оборудование
CREATE TABLE equipments (
    id INTEGER PRIMARY KEY,
    group_id INTEGER NOT NULL REFERENCES groups(id),
    composition TEXT NOT NULL
);

-- Табличка для организации многие-ко-многим между группами и учеными
CREATE TABLE scientist_groups (
    group_id INTEGER NOT NULL REFERENCES groups(id),
    scientist_id INTEGER NOT NULL REFERENCES scientist(id),
    CONSTRAINT group_membership_id PRIMARY KEY (group_id, scientist_id)
);

-- Ученые
CREATE TABLE scientist (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INTEGER NOT NULL,
    status VARCHAR(255),
    expedition_experience INTEGER
);

-- Исследования
CREATE TABLE researchers (
    id INTEGER PRIMARY KEY,
    territory_id INTEGER NOT NULL REFERENCES territories(id),
    data DATE DEFAULT CURRENT_DATE
);

-- Территории
CREATE TABLE territories (
    id INTEGER PRIMARY KEY,
    area INTEGER NOT NULL,
    type VARCHAR(255) NOT NULL
);

-- Объекты исследования
CREATE TABLE object_types (
    id INTEGER PRIMARY KEY,
    species_or_breed VARCHAR(255) NOT NULL,
    territory_id INTEGER NOT NULL REFERENCES territories(id)
);

-- Заполнение тестовыми данными в соответствии с выданным текстом
INSERT INTO territories(id, area, type) VALUES (1, 176, 'Лес');
INSERT INTO territories(id, area, type) VALUES (2, 152, 'Плато');

INSERT INTO object_types(species_or_breed, territory_id) VALUES ('мох обыкновенный', 2);
INSERT INTO object_types(species_or_breed, territory_id) VALUES ('мох необыкновенный', 2);
INSERT INTO object_types(species_or_breed, territory_id) VALUES ('дуб зеленый, златая цепь на дубе том', 1);

INSERT INTO researchers(territory_id, data) VALUES (2, '2026-02-11');

INSERT INTO organizations(name, finances, address) VALUES ('Фирма Дяди Вовы', 520000000, 'ул Пушкина, д Колотушкина');

INSERT INTO groups(organization_id, target, expected_result, research_id) VALUES (1, 'найти чо-нить прикольное', 'прикольчик 1, прикольчик 2, прикольчик 3', 1);

INSERT INTO equipments(group_id, composition) VALUES (1, 'ножнички, щипчики, лупа-пупа, компуктер');

INSERT INTO scientist(name, age, status, expedition_experience)
VALUES ('Вася Пупкин', 52, 'Доцент', 5),
       ('Иван Иванов', 67, 'Доктор наук', 28),
       ('Ашот Узбеков', 44, 'Шаурмист', 0);

INSERT INTO scientist_groups(group_id, scientist_id) VALUES (1, 1), (1, 2), (1, 3);

COMMIT;