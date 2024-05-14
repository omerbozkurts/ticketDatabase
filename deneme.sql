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

--Bu tabloda pozisyonlar tutulur. geliþtirilecek
create table tblPozisyon(
pozisyonID int identity(1,1) primary key,
PozisyonAdi varchar(20) not null 
)

--Bu tablo personel bilgilerini tutar.
create table tblPersonel(
Ad varchar(20) not null,
Soyad varchar(20) not null,
TcKimlikNO char(11) primary key not null, --uniqe demedim primary key ile ayný anda olmuyor.
DogumTarihi date not null,
Cinsiyet bit not null, -- bunu düzenleriz.örneðini bulamadým.
MedeniHal bit not null, -- ""
Tel char(10) constraint chkTEl check (Tel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Mail Varchar(50) constraint chkMail check (Mail like '%@%.%')  unique not null,
)

--POZÝSYON VE PERSONEL ARASINDA "ÇALIÞIR" ÝLÝÞKÝSÝ VAR VE BUNA AÝT BAÞLAMA VE BÝTÝÞ TARÝHÝ DÝYE 2 ÖZELLÝK VAR.
--Bu iliþki m-n iliþkisi. PDF te kitap ve okuma listesi arasýnda da m-n iliþkisi ve ona ait özellikler için yeni tablo oluþturuluyor.
create table calisirPersonelPozisyon(
ID int identity (1,1) primary key,
--TcKimlikNO char foreign key references tblPersonel (TcKimlikNO), 
)

