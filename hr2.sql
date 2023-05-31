drop table member cascade constraints;

drop table category1 cascade constraints;
drop sequence seq_category1;

drop table category2 cascade constraints;
drop sequence seq_category2;

drop table product cascade constraints;
drop sequence seq_product;

drop table notice cascade constraints;
drop sequence seq_notice;

drop table report cascade constraints;
drop sequence seq_report;

drop table frfr_order cascade constraints;
drop sequence seq_frfr_order;

drop table help cascade constraints;
drop sequence seq_help;

drop table answer cascade constraints;
drop sequence seq_answer;  

drop table review cascade constraints;
drop sequence seq_review;

drop table review_like cascade constraints;
drop sequence seq_review_like;

drop table support cascade constraints;
drop sequence seq_support;

drop table wish cascade constraints;
drop sequence seq_wish;


create table member(
    user_id VARCHAR2(20) PRIMARY KEY,
    user_pwd VARCHAR2(20) NOT NULL,
    user_name VARCHAR2(50) NOT NULL,
    user_nick VARCHAR2(50),
    user_tel number NOT NULL,
    user_postcode number,
    user_addr1 VARCHAR2(255),
    user_addr2 VARCHAR2(255),
    user_type number,
    user_account number,
    user_bank number 
);

create table category1(
    cate_num number primary key, 
    cate_name varchar2(50) not null
);
create sequence seq_category1;

create table category2(
    cate_num number primary key, 
    cate_name varchar2(50) not null, 
    cate_parent_num number references category1(cate_num) on delete cascade
);
create sequence seq_category2;

create table product(
    product_num number primary key,
    product_seller_id varchar2(20) references member(user_id) on delete cascade,
    product_title varchar2(50) not null,
    product_content varchar2(500),
    product_price number not null,
    product_quantity number not null,
    product_date date,
    product_hit number DEFAULT 0,
    product_pick number DEFAULT 0,
    product_view_type number default 1,
    frfr_category1 number references category1(cate_num) on delete set null,
    frfr_category2 number references category2(cate_num) on delete set null
);
create sequence seq_product;

create table report(
report_num number primary key,
product_num number not null references product(product_num) on delete cascade,
report_title varchar2(50) not null,
report_content varchar2(500) not null,
report_writer_id varchar2(20) references member(user_id) on delete cascade,
report_seller_id varchar2(20) references member(user_id) on delete cascade,
report_date date
);
create sequence seq_report;

create table support(
    support_num number primary key,
    support_parent_num number,
    support_product_num number references product(product_num) on delete cascade,
    support_writer varchar2(50) references member(user_id) on delete cascade,
    support_title varchar2(500),
    support_content varchar2(1000),
    support_date date not null
);
create sequence seq_support;

create table wish(
    wish_num number primary key,
    wish_product_num number references product(product_num) on delete cascade,
    wish_user_id varchar2(20) references member(user_id) on delete cascade
);
create sequence seq_wish;

create table frfr_order(                                                                              
order_num number primary key,
product_num number references product(product_num) on delete cascade,
order_id varchar2(50) not null references member(user_id) on delete cascade,
order_count number,
order_type number,
order_date date
);
create sequence seq_frfr_order;

create table review(
    review_num number primary key,
    review_title varchar2(50) not null,
    review_content varchar2(500) not null,
    review_writer varchar2(20) references member(user_id) on delete cascade,
    review_date date,
    review_product_num number references product(product_num) on delete cascade,
    review_like_hit number
);
create sequence seq_review;

create table review_like(
    review_like_num number primary key,
    review_like_user_id varchar2(20) references member(user_id) on delete cascade,
    review_like_review_num number references review(review_num) on delete cascade
);
create sequence seq_review_like;

create table notice(
   notice_num number primary key,
   notice_type number,
   notice_title varchar2(50) not null,
   notice_content varchar2(500) not null,
   notice_date date,
   notice_hit number default 0
);
create sequence seq_notice;

create table help(
    help_num number primary key,
    help_type number,
    help_writer_id varchar2(50) references member(user_id) on delete cascade,
    help_date date not null,
    help_title varchar2(100),
    help_content varchar2(1000)
);
create sequence seq_help;

create table answer(
          answer_num number primary key,
          help_num number references help(help_num) on delete cascade,
          user_id varchar2(50) references member(user_id) on delete cascade,
          answer_content varchar2(1000) not null,
          answer_date date not null
      );
create sequence seq_answer;

SELECT
    *
FROM member;
--------------------------------------------------------
SELECT
    *
FROM product;
--------------------------------------------------------
SELECT
    *
FROM category1;
--------------------------------------------------------
SELECT
    *
FROM category2;
--------------------------------------------------------
SELECT
    *
FROM report;
--------------------------------------------------------
SELECT
    *
FROM support;
--------------------------------------------------------
SELECT
    *
FROM wish;
--------------------------------------------------------
SELECT 
    *
FROM frfr_order;
-------------------------------------------------------- 
SELECT
    *
FROM review;
--------------------------------------------------------
SELECT
    *
FROM review_like;
--------------------------------------------------------
SELECT
    *
FROM notice;
--------------------------------------------------------
SELECT
    *
FROM help;
--------------------------------------------------------
SELECT
     *
FROM answer;
-------------------------------------------------------- 