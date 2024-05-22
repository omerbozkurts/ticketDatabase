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
ID int identity (1,1) primary key,
Ad varchar(20) not null,
Soyad varchar(20) not null,
TcKimlikNO char(11) unique not null,
DogumTarihi date not null,
Cinsiyet bit not null, -- 0: erkek,1: kadin .Bunu düzenleriz.örneðini bulamadým.
MedeniHal bit not null, -- 0: bekar,1: evli.
Tel char(10) constraint chkTEl check (Tel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Mail Varchar(50) constraint chkMail check (Mail like '%@%.%')  unique not null,
)

--POZÝSYON VE PERSONEL ARASINDA "ÇALIÞIR" ÝLÝÞKÝSÝ VAR VE BUNA AÝT BAÞLAMA VE BÝTÝÞ TARÝHÝ DÝYE 2 ÖZELLÝK VAR.
--Bu iliþki m-n iliþkisi. PDF te kitap ve okuma listesi arasýnda da m-n iliþkisi ve ona ait özellikler için yeni tablo oluþturuluyor.
create table calisirPersonelPozisyon(
ID int identity (1,1) primary key,
--PersonelTCNO int foreign key references tblPersonel (TcKimlikNO), !böyle olduðunda hata veriyor çünkü tcKimlikNO char, bu tablonun primary key i int.Bu yüzden personele ID ekliyorum.
PersonelID int foreign key references tblPersonel(ID) not null,
PozisyonID int foreign key references tblPozisyon(pozisyonID) not null,
BaslamaTarihi date default getdate() not null,
AyrilmaTarihi date default null --deðer belirtilmediði sürece sabit null deðerini alýr. 
)

-- Personel - Sefer arasýndaki n'e m iliþki için oluþturulan tablo.
create table seferPersonel(
PersonelID int foreign key references tblPersonel (ID) not null,
--SeferID int foreign key references tblSefer(ID) not null, þimdilik sefer tablosu yok
--constraint pkttblseferPersonel primary key (PersonelID,SeferID)
)

-- Personel - Bilet arasýnda 1'e n iliþkisi var. Ýliþkilerdeki özellik n tarafýndaki varlýða sütun eklenir. 
--BU tablo bilet bilgilerini tutar.
create table tblBilet(
ID int identity(1,1) primary key,
Ucret money not null,
KesilmeTarihi date default getdate(), -- alýndýðý tarih getilir.
KoltukNO int unique not null,
CheckinDurumu smallint default 0 not null, --1 olduðunda checkin yapýlmýþ. örnekteki üye tablosu aktif mi kýsmýndan kopya çektim.
CheckinTarihSaati datetime default null, --yapýlmadýðý sürece 0 kabul edilir.?? emin deðilim
PersonelIDbiletKeser int foreign key references tblPersonel(ID) not null
)

