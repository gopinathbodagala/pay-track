create database  if not exists `paytrack`;
use `paytrack`;

drop table if exists `receipts`;
drop table if exists `provider_clients`;
drop table if exists `clients`;
drop table if exists `providers`;

create table `providers` (
  `id` int(11) not null auto_increment,
  `first_name` varchar(100)  not null,
  `last_name` varchar(100)  not null,
  `email_id` varchar(50)  not null,
  `mobile_number` varchar(20)  not null,
  `address` varchar(300)  not null,
  `service_name` varchar(200)  not null,
  primary key  (`id`),
  unique key `uk_email_id` (`email_id`),
  unique key `uk_mobile` (`mobile_number`)
) engine=innodb default charset=utf8;

create table `clients` (
  `id` int(11) not null auto_increment,
  `first_name` varchar(100)  not null,
  `last_name` varchar(100)  not null,
  `email_id` varchar(50)  not null,
  `mobile_number` varchar(20)  not null,
  `address` varchar(300)  not null,
  primary key  (`id`),
  unique key `uk_clients_email_id` (`email_id`),
  unique key `uk_clients_mobile_number` (`mobile_number`)
) engine=innodb default charset=utf8;


create table `provider_clients` (
  `id` int(11) not null auto_increment,
  `provider_id` int(11) default null,
  `client_id` int(11) default null,
  primary key  (`id`),
  key `provider_foreign_key` (`provider_id`),
  key `client_foreign_key` (`client_id`),
  constraint `client_foreign_key` foreign key (`client_id`) references `clients` (`id`) on delete no action on update no action,
  constraint `provider_foreign_key` foreign key (`provider_id`) references `providers` (`id`) on delete no action on update no action
) engine=innodb default charset=utf8;


create table `receipts` (
  `id` int(11) not null auto_increment,
  `provider_clients_id` int(11) default null,
  `from` timestamp null default null,
  `to` timestamp null default null,
  `amount` decimal(10,0) default null,
  `payment_date` timestamp null default null,
  primary key  (`id`),
  key `provider_clients_id` (`provider_clients_id`),
  constraint `provider_clients_id` foreign key (`provider_clients_id`) references `provider_clients` (`id`) on delete no action on update no action
) engine=innodb default charset=utf8;
