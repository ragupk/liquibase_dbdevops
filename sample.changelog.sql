--liquibase formatted sql

--changeset ragu:1
create table person (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)

--changeset ragu:2
create table company (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)

--changeset suresh:3
alter table person add column country varchar(2)

--changeset suresh:4
ALTER TABLE person ADD worksfor_company_id INT;

--changeset arun:1
ALTER TABLE person ADD CONSTRAINT fk_person_worksfor FOREIGN KEY (worksfor_company_id) REFERENCES company(id);