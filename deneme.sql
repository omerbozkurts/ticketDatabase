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
 ilID char(2) foreign key references tblIl(ilID) 
 on delete cascade on update cascade not null --referans edilen tabloda kay�t silinirse bu tabloda da silinir.
)

--Bu tabloda pozisyonlar tutulur. geli�tirilecek
create table tblPozisyon(
pozisyonID int identity(1,1) primary key,
PozisyonAdi varchar(20) not null 
)

--Bu tablo personel bilgilerini tutar.
create table tblPersonel(
Ad varchar(20) not null,
Soyad varchar(20) not null,
TcKimlikNO char(11) primary key not null, --uniqe demedim primary key ile ayn� anda olmuyor.
DogumTarihi date not null,
Cinsiyet bit not null, -- bunu d�zenleriz.�rne�ini bulamad�m.
MedeniHal bit not null, -- ""
Tel char(10) constraint chkTEl check (Tel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Mail Varchar(50) constraint chkMail check (Mail like '%@%.%')  unique not null,
)

--POZ�SYON VE PERSONEL ARASINDA "�ALI�IR" �L��K�S� VAR VE BUNA A�T BA�LAMA VE B�T�� TAR�H� D�YE 2 �ZELL�K VAR.
--Bu ili�ki m-n ili�kisi. PDF te kitap ve okuma listesi aras�nda da m-n ili�kisi ve ona ait �zellikler i�in yeni tablo olu�turuluyor.
create table calisirPersonelPozisyon(
ID int identity (1,1) primary key,
--TcKimlikNO char foreign key references tblPersonel (TcKimlikNO), 
)

