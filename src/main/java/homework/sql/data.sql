drop table if exists parents_children;
drop table if exists children;
drop table if exists teachers;
drop table if exists parents;

create table parents
(
    id   bigserial primary key,
    name varchar(20),
    age  int
);

create table teachers
(
    id   bigserial primary key,
    name varchar(20)
);

create table children
(
    id         bigserial primary key,
    name       varchar(20),
    age        int,
    -- представим, что у ребенка может быть только один воспитатель
    teacher_id bigint not null references teachers (id)
);

create table parents_children
(
    parents_id bigint not null references parents (id),
    child_id   bigint not null references children (id),
    primary key (parents_id, child_id)
);


insert into parents(name, age)
values ('Igor', 25),
       ('Svetlana', 24),
       ('Sergey', 40),
       ('Agata', 36),
       ('Petr', 35),
       ('Alexey', 44),
       ('Natalia', 40),
       ('Roman', 23),
       ('Ekaterina', 26),
       ('Sofia', 39),
       ('Dmitry', 27),
       ('Violetta', 31),
       ('Konstantin', 46),
       ('Olga', 45);

insert into teachers(name)
values ('Teacher 1'),
       ('Teacher 2');

insert into children(name, age, teacher_id)
values ('Alexey', 5, 1),
       ('Kristina', 6, 1),
       ('Roman', 5, 1),
       ('Natalia', 4, 1),
       ('Anna', 5, 1),
       ('Lera', 6, 1),
       ('Vladimir', 4, 1),
       ('Vladimir', 3, 1),
       ('Svetlana', 5, 2),
       ('Marina', 6, 2),
       ('Pavel', 5, 2),
       ('Elena', 6, 2),
       ('Karina', 4, 2),
       ('Aleksandr', 5, 2);

insert into parents_children (parents_id, child_id)
values (1, 1),
       (2, 1),
       (3, 2),
       (4, 2),
       (3, 3),
       (4, 3),
       (5, 4),
       (5, 14),
       (6, 5),
       (7, 5),
       (8, 6),
       (9, 6),
       (8, 7),
       (9, 7),
       (10, 8),
       (11, 8),
       (10, 9),
       (11, 9),
       (10, 10),
       (11, 10),
       (12, 11),
       (13, 11),
       (12, 12),
       (13, 12),
       (14, 13);


-- Первые 10 уникальных имен людей от 30 до 40 лет,
-- отсортированных в порядке возрастания, у которых детей ровно 2
select distinct p.name
from parents p
         join parents_children pc on p.id = pc.parents_id
where p.age >= 30
  and p.age <= 40
group by p.name, p.id
having count(child_id) = 2
order by p.name
limit 10;


-- Родители одиночки
select p.name
from parents p
         join parents_children pc on p.id = pc.parents_id
where pc.child_id in (select child_id
                      from parents_children
                      group by child_id
                      having count(child_id) = 1)
group by p.name, p.id
order by p.name;


-- Имя учителя и количество учеников
select t.name, count(*) as count_children
from teachers t
         join children c on t.id = c.teacher_id
group by t.name, t.id
order by t.name
