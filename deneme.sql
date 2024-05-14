create database biletSatis
use biletSatis

--Bu tabloda iller tutulur.
create table tblIl(
ilID char(2) primary key,
--Türkiyedeki en uzun il 14 harf(Afyonkarahisar)
Ad varchar(14) not null,
)

 --Bu tabloda illere ait ilçeler tutulur.
 create table tblIlce(
 ilceID int identity(1,1) primary key, --identity 1 den baþlayýp 1 arttýrarak ilçelere ID verir.Sadece int deðiþkeninde kullanýlýr.
 --Türkiyedeki en uzun ilçe 16 harf.
 Ad varchar(16) not null,
 ilID char(2) foreign key references tblIl(ilID) 
 on delete cascade on update cascade not null --referans edilen tabloda kayýt silinirse bu tabloda da silinir.
)

--Bu tabloda pozisyonlar tutulur.
create table tblPozisyon(
pozisyonID varchar(20),
)