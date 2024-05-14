create database biletSatis
use biletSatis

--Bu tabloda iller tutulur.
create table tblIl(
ilID char(2) primary key,
--T�rkiyedeki en uzun il 14 harf(Afyonkarahisar)
Ad varchar(14) not null,
)

 --Bu tabloda illere ait il�eler tutulur.
 create table tblIlce(
 ilceID int identity(1,1) primary key, --identity 1 den ba�lay�p 1 artt�rarak il�elere ID verir.Sadece int de�i�keninde kullan�l�r.
 --T�rkiyedeki en uzun il�e 16 harf.
 Ad varchar(16) not null,
 --bu kodlar� anlamad�m.�imdilik yaz�yorum.
 --ilID char(2) foreign key references tblIl(ilID)
 -- on delete cascade on update cascade notnull
)
