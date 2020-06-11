--liquibase formatted sql

--changeset ragu:1
create table person (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback  drop table person

--changeset ragu:2
create table company (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback drop table company

--changeset suresh:3
alter table person add column country varchar(2)
--rollback alter table person drop column country

--changeset arun:4
insert into company values (1,'Alex','ABCD','TXA','NewYork')
--rollback delete from company where id=1
