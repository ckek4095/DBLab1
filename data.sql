-- Заполнение тестовыми данными
INSERT INTO territories(area, type) VALUES (176, 'Лес');
INSERT INTO territories(area, type) VALUES (152, 'Плато');

INSERT INTO object_types(species_or_breed, territory_id) VALUES 
    ('moh obichniy', 2),
    ('moh neobichniy', 2),
    ('dyb green', 1);

INSERT INTO researchers(territory_id, data) VALUES (2, '2026-02-11');

INSERT INTO organizations(name, finances, address) VALUES 
    ('Firma Uncle Vova', 520000000, 'Neznamovo 52'); 

INSERT INTO groups_(organization_id, target, expected_result, research_id) VALUES 
    (1, 'find something hehe', 'hehe 1, hehe 2, hehe 3', 1);  

INSERT INTO equipments(group_id, composition) VALUES 
    (1, 'scissors, shovel, computer');  

INSERT INTO scientist(name, birthday_data, status) VALUES 
    ('Vyasya Pupkin', "2006-11-11", 'Docent'),     
    ('Vanya Ivanov', "1999-03-15", 'Scientist'), 
    ('Ashot Yzbekov', "2001-11-29", 'Shayrmist');    

INSERT INTO scientist_groups(group_id, scientist_id) VALUES 
    (1, 1),  -- группа 1, Вася Пупкин
    (1, 2),  -- группа 1, Ваня Иванов
    (1, 3);  -- группа 1, Ашот Узбеков