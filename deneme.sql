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
ID int identity (1,1) primary key,
Ad varchar(20) not null,
Soyad varchar(20) not null,
TcKimlikNO char(11) unique not null,
DogumTarihi date not null,
Cinsiyet bit not null, -- 0: erkek,1: kadin .Bunu d�zenleriz.�rne�ini bulamad�m.
MedeniHal bit not null, -- 0: bekar,1: evli.
Tel char(10) constraint chkTEl check (Tel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Mail Varchar(50) constraint chkMail check (Mail like '%@%.%')  unique not null,
)

--POZ�SYON VE PERSONEL ARASINDA "�ALI�IR" �L��K�S� VAR VE BUNA A�T BA�LAMA VE B�T�� TAR�H� D�YE 2 �ZELL�K VAR.
--Bu ili�ki m-n ili�kisi. PDF te kitap ve okuma listesi aras�nda da m-n ili�kisi ve ona ait �zellikler i�in yeni tablo olu�turuluyor.
create table calisirPersonelPozisyon(
ID int identity (1,1) primary key,
--PersonelTCNO int foreign key references tblPersonel (TcKimlikNO), !b�yle oldu�unda hata veriyor ��nk� tcKimlikNO char, bu tablonun primary key i int.Bu y�zden personele ID ekliyorum.
PersonelID int foreign key references tblPersonel(ID) not null,
PozisyonID int foreign key references tblPozisyon(pozisyonID) not null,
BaslamaTarihi date default getdate() not null,
AyrilmaTarihi date default null --de�er belirtilmedi�i s�rece sabit null de�erini al�r. 
)

-- Personel - Sefer aras�ndaki n'e m ili�ki i�in olu�turulan tablo.
create table seferPersonel(
PersonelID int foreign key references tblPersonel (ID) not null,
--SeferID int foreign key references tblSefer(ID) not null, �imdilik sefer tablosu yok
--constraint pkttblseferPersonel primary key (PersonelID,SeferID)
)

-- Personel - Bilet aras�nda 1'e n ili�kisi var. �li�kilerdeki �zellik n taraf�ndaki varl��a s�tun eklenir. 
--BU tablo bilet bilgilerini tutar.
create table tblBilet(
ID int identity(1,1) primary key,
Ucret money not null,
KesilmeTarihi date default getdate(), -- al�nd��� tarih getilir.
KoltukNO int unique not null,
CheckinDurumu smallint default 0 not null, --1 oldu�unda checkin yap�lm��. �rnekteki �ye tablosu aktif mi k�sm�ndan kopya �ektim.
CheckinTarihSaati datetime default null, --yap�lmad��� s�rece 0 kabul edilir.?? emin de�ilim
PersonelIDbiletKeser int foreign key references tblPersonel(ID) not null
)

