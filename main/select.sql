IF DB_ID('BILETSATIS') IS NOT NULL
	BEGIN 
		ALTER DATABASE [BILETSATIS] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		USE MASTER
		DROP DATABASE BILETSATIS
	END 
GO

CREATE DATABASE BILETSATIS
	ON PRIMARY (	
			NAME = 'BILETSATISDB',	
			FILENAME = 'C:\database\biletsatis_db.mdf', 
			SIZE = 50MB, 
			MAXSIZE = 1000MB, 
			FILEGROWTH=30MB
				) 
	LOG ON (
		NAME = 'BILETSATISLOG', 
		FILENAME= 'C:\database\biletsatis_log.ldf', 
		SIZE= 10MB, 
		MAXSIZE= 100MB, 
		FILEGROWTH = 20MB) 
GO

USE BILETSATIS

	CREATE TABLE IL(
		IlKodu CHAR(2) PRIMARY KEY,
		IlAdi VARCHAR(20) NOT NULL
	)

GO

	CREATE TABLE ILCE(
		IlceId INT IDENTITY(1,1) PRIMARY KEY,
		IlceAdi VARCHAR(20) NOT NULL,
		IlKodu CHAR(2) FOREIGN KEY REFERENCES IL(IlKodu) ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT notNullIlceIl NOT NULL
	)

GO

	CREATE TABLE FIRMA(
		FirmaId INT IDENTITY(1,1) PRIMARY KEY,
		FirmaAd VARCHAR(50) NOT NULL,
		WebAdresi VARCHAR(30) CONSTRAINT chkWebsite CHECK (WebAdresi LIKE 'www.%.%' )  CONSTRAINT notNullFirmaWeb NOT NULL,
		FirmaAdres VARCHAR(50) NOT NULL,
		KurulusTarih DATE NOT NULL,
		TelNo CHAR(10) CONSTRAINT chkTelFirma CHECK (TelNo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') CONSTRAINT notNullFirmaNo NOT NULL,
		TelNo2 CHAR(10) CONSTRAINT chkTelFirma2 CHECK (TelNo2 LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
		TelNo3 CHAR(10) CONSTRAINT chekTelFirma3 CHECK (TelNo3 LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
		FirmaIlKodu CHAR(2) FOREIGN KEY REFERENCES IL(IlKodu) CONSTRAINT notNullFirmaIl NOT NULL,
		FirmaIlceKodu INT FOREIGN KEY REFERENCES ILCE(IlceId) CONSTRAINT notNullFirmaIlce NOT NULL
	)

GO

	CREATE TABLE SUBE(
		SubeId INT IDENTITY(1,1) PRIMARY KEY,
		SubeAd VARCHAR(50) NOT NULL,
		SubeAdres VARCHAR(50) NOT NULL,
		TelNo CHAR(10) CONSTRAINT chkTelSube CHECK (TelNo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') CONSTRAINT notNullSubeNo NOT NULL,
		TelNo2 CHAR(10) CONSTRAINT chkTelSube2 CHECK (TelNo2 LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
		TelNo3 CHAR(10) CONSTRAINT chekTelSube3 CHECK (TelNo3 LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
		SubeIl CHAR(2) FOREIGN KEY REFERENCES IL(IlKodu) NOT NULL,
		SubeIlce INT FOREIGN KEY REFERENCES ILCE(IlceId) NOT NULL,
		SubeFirma INT FOREIGN KEY REFERENCES FIRMA(FirmaId) NOT NULL
	)

GO

	CREATE TABLE POZISYON(
		PozisyonId INT IDENTITY(1,1) PRIMARY KEY,
		PozisyonAd VARCHAR(20) NOT NULL
	)

GO

	CREATE TABLE PERSONEL(
		PersonelId INT IDENTITY(1,1) PRIMARY KEY ,
		TCNo CHAR(11) UNIQUE NOT NULL,
		Ad VARCHAR(20) NOT NULL,
		Soyad VARCHAR(20) NOT NULL,
		DogumTarihi DATE NOT NULL,
		Cinsiyet CHAR(1) CONSTRAINT chkCinsiyetPersonel CHECK (Cinsiyet='E' OR Cinsiyet='K') 
														CONSTRAINT notNullCinsiyetPersonel NOT NULL, -- cinsiyet degerleri k ya da e olmalidir
		MedeniHal CHAR(1) CONSTRAINT chkMedeniHalPersonel CHECK (MedeniHal = 'E' OR MedeniHal= 'B') 
														  CONSTRAINT notNullMedeniPersonel NOT NULL, -- medeni hal degerleri e ya da b olmalidir
		TelefonNo CHAR(10) CONSTRAINT chkTelPersonel CHECK (TelefonNo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') 
													 CONSTRAINT uniqTelPersonel UNIQUE
													 CONSTRAINT notNullPersonelTel NOT NULL,-- telefon numarasi 10 haneli olmali ve sayilardan olusmalidir
		EPosta VARCHAR(50) CONSTRAINT chekPostaPersonel CHECK (EPosta LIKE '%@%.%') 
														CONSTRAINT uniqMailPersonel UNIQUE
														CONSTRAINT notNullPersonelPosta NOT NULL,-- eposta adresinde @ isareti ve sonrasinda . olmalidir
		BaslangicTarih DATE NOT NULL,
		AyrilmaTarih DATE DEFAULT NULL,
		DogumIl CHAR(2) FOREIGN KEY REFERENCES IL(IlKodu) NOT NULL,
		DogumIlce INT FOREIGN KEY REFERENCES ILCE(IlceId) NOT NULL,
		Pozisyon INT FOREIGN KEY REFERENCES POZISYON(PozisyonId) NOT NULL,
		Firma INT FOREIGN KEY REFERENCES FIRMA(FirmaId) NOT NULL,
		Sube INT FOREIGN KEY REFERENCES SUBE(SubeId) NOT NULL
		)

GO

	CREATE TABLE YOLCU(
		YolcuId INT IDENTITY(1,1) PRIMARY KEY,
		TCNo CHAR(11) UNIQUE NOT NULL,
		Ad VARCHAR(20) NOT NULL,
		Soyad VARCHAR(20) NOT NULL,
		Cinsiyet CHAR(1) CONSTRAINT yolcuCinsiyetChk CHECK (Cinsiyet= 'E' OR Cinsiyet = 'K') CONSTRAINT notNullYolcuCinsiyet NOT NULL,
		DogumTarihi DATE NOT NULL,
		TelefonNo CHAR(10) CONSTRAINT yolcuTelCheck CHECK (TelefonNo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') 
													CONSTRAINT uniqueYolcuTel UNIQUE
													CONSTRAINT notNullYolcuTel NOT NULL,
		EPosta CHAR(50) CONSTRAINT yolcuPostaCheck CHECK (EPosta LIKE '%@%.%') 
												   CONSTRAINT uniqueYolcuPosta UNIQUE
												   CONSTRAINT notNullYolcuPosta NOT NULL,
		Aktiflik SMALLINT DEFAULT 1 NOT NULL, -- aktifligin sonlanmasi durumunda deger 0 olarak degistirilir
		YAS AS DATEDIFF(YY,DogumTarihi,GETDATE()),
		Sifre VARCHAR(30) CONSTRAINT checkSifre CHECK( LEN(Sifre)>=8 AND 
														Sifre LIKE '%[0-9]%' AND
														Sifre COLLATE Latin1_General_BIN LIKE '%[A-Z]%' AND 
														Sifre COLLATE Latin1_General_BIN LIKE '%[a-z]%') CONSTRAINT notNullYolcu NOT NULL, 
												-- sifrede en az bir sayi,bir kucuk harf ve bir tane buyuk harf olmasi ve sifrenin 8 karakterden uzun olmasi saglanir
	)

GO

	CREATE TABLE ARAC_TUR(
		AracTurId INT IDENTITY(1,1) PRIMARY KEY,
		AracTurAd CHAR(1) NOT NULL,
	)

GO

	CREATE TABLE MARKA(
		MarkaId INT IDENTITY(1,1) PRIMARY KEY,
		MarkaAd VARCHAR(20) NOT NULL,
		AracTurId INT FOREIGN KEY REFERENCES ARAC_TUR(AracTurId)
							CONSTRAINT notNullMarkaAracTur NOT NULL
	)

GO

	CREATE TABLE ARAC_MODEL(
		ModelId INT IDENTITY(1,1) PRIMARY KEY,
		ModelAd VARCHAR(20) NOT NULL,
		MotorHacmi VARCHAR(10), -- araclarda motor hacmi terimi kullanilir
		ItmeGucu VARCHAR(10), -- ucaklarda ise jet motoru oldugu icin motor hacmi kavrami yoktur bunu yerine itki gucu kullanilir
		MotorGucu VARCHAR(10) NOT NULL,
		BagajKapasite VARCHAR(10) NOT NULL,
		KoltukSayisi INT NOT NULL,
		MarkaId INT FOREIGN KEY REFERENCES MARKA(MarkaId)
								CONSTRAINT notNullModelMarka NOT NULL,
		AracTurId INT FOREIGN KEY REFERENCES ARAC_TUR(ARACTURID)
								  CONSTRAINT notNullModelTur NOT NULL
	)

GO

	CREATE TABLE ARAC(
		AracId INT IDENTITY(1,1) PRIMARY KEY,
		AracTur INT FOREIGN KEY REFERENCES ARAC_TUR(AracTurId)
								CONSTRAINT notNullAracAractur NOT NULL,
		ModelId INT FOREIGN KEY REFERENCES ARAC_MODEL(ModelId)
								CONSTRAINT notNullAracModel NOT NULL,
		MarkaId INT FOREIGN KEY REFERENCES MARKA(MarkaId)
								CONSTRAINT notNullAracMarka NOT NULL

	)

GO

	CREATE TABLE FIRMA_ARAC(
		FirmaAracId INT IDENTITY(1,1) PRIMARY KEY,
		AracBenzersizNo VARCHAR(10) CONSTRAINT uniqueFirmaAracNo UNIQUE 
									  CONSTRAINT notNullFirmaAracNo NOT NULL,
		AlisKm INT NOT NULL,
		GuncelKm INT NOT NULL,
		AlisMaliyet MONEY NOT NULL,
		AlisTarih DATE NOT NULL,
		IskartaTarih DATE,
		FirmaId INT FOREIGN KEY REFERENCES FIRMA(FirmaId) NOT NULL,
		AracId INT FOREIGN KEY REFERENCES ARAC(AracId)
								CONSTRAINT notNullFirmaAracArac NOT NULL
	)

GO

	CREATE TABLE DURAKLAR(
		DurakId INT IDENTITY(1,1) PRIMARY KEY,
		DurakTur CHAR(1) NOT NULL, 
		DurakIlId CHAR(2) FOREIGN KEY REFERENCES IL(IlKodu)
									  CONSTRAINT notNullDurakIl NOT NULL,
		DurakIlceId INT FOREIGN KEY REFERENCES ILCE(IlceId)
									CONSTRAINT notNullDurakIlce NOT NULL
	)

GO

	CREATE TABLE GUZERGAH(
		GuzergahId INT IDENTITY(1,1) PRIMARY KEY,
		KalkisDurak INT FOREIGN KEY REFERENCES DURAKLAR(DurakId)
									CONSTRAINT notNullGuzergahKalkis NOT NULL,
		VarisDurak INT FOREIGN KEY REFERENCES DURAKLAR(DurakId)
									CONSTRAINT notNullGuzergahVaris NOT NULL
	
	)

GO

	CREATE TABLE UGRANILAN_DURAK_GUZERGAH(
		UgranilanDurakId INT IDENTITY(1,1) PRIMARY KEY,
		DurakIsim VARCHAR(20) NOT NULL,
		DurakSira INT NOT NULL,
		DurakId INT FOREIGN KEY REFERENCES DURAKLAR(DurakId)
								CONSTRAINT notNullUgranilanDurak NOT NULL,
		DurakIl CHAR(2) FOREIGN KEY REFERENCES IL(IlKodu)
									CONSTRAINT notNullUgranilanIl NOT NULL,
		DurakIlce INT FOREIGN KEY REFERENCES ILCE(IlceId)
								  CONSTRAINT notNullUgranilanIlce NOT NULL,
		Guzergah INT FOREIGN KEY REFERENCES GUZERGAH(GuzergahId)
								 CONSTRAINT notNullUgranilanGuzergah NOT NULL
	)

GO

	CREATE TABLE SEFER(
		SeferId INT IDENTITY(1,1) PRIMARY KEY,
		KalkisTarih DATE NOT NULL,
		VarisTarih DATE NOT NULL,
		Firma INT FOREIGN KEY REFERENCES FIRMA(FirmaId)
							  CONSTRAINT notNullSeferFirma NOT NULL,
		Guzergah INT FOREIGN KEY REFERENCES GUZERGAH(GuzergahId)
								 CONSTRAINT notNullSeferGuzergah NOT NULL,
		KalkisDurak INT FOREIGN KEY REFERENCES DURAKLAR(DurakId)
									CONSTRAINT notNullSeferKalkis NOT NULL,
		KalkisSaat TIME NOT NULL,
		VarisDurak INT FOREIGN KEY REFERENCES DURAKLAR(DURAKID)
								   CONSTRAINT notNullSeferVaris NOT NULL,
		VarisSaat TIME NOT NULL,
		Arac INT FOREIGN KEY REFERENCES FIRMA_ARAC(FirmaAracId)
							 CONSTRAINT notNullSeferArac NOT NULL,
		AnlikKonum VARCHAR(20) NOT NULL
	)

GO

	CREATE TABLE UGRANILAN_DURAK_SEFER(
		UgranilanDurakId INT IDENTITY(1,1) PRIMARY KEY,
		DurakIsim VARCHAR(20) NOT NULL,
		DurakSira INT NOT NULL,
		DurakId INT FOREIGN KEY REFERENCES DURAKLAR(DurakId)
								CONSTRAINT notNullUgranilanDurak NOT NULL,
		DurakIl CHAR(2) FOREIGN KEY REFERENCES IL(IlKodu)
								CONSTRAINT notNullUgranilanDurakIl NOT NULL,
		DurakIlce INT FOREIGN KEY REFERENCES ILCE(IlceId)
								CONSTRAINT notNullUgranilanIlce NOT NULL,
		SeferDurak INT FOREIGN KEY REFERENCES SEFER(SeferId)
									CONSTRAINT notNullUgranilanSefer NOT NULL
	)

GO

	CREATE TABLE SEFER_PERSONEL(
		SeferPersonelId INT IDENTITY(1,1) PRIMARY KEY,
		PersonelId INT FOREIGN KEY REFERENCES PERSONEL(PersonelId)
								   CONSTRAINT chkNullSeferPersonel NOT NULL,
		Sefer INT FOREIGN KEY REFERENCES SEFER(SeferId)
							  CONSTRAINT chkNullSeferSefer NOT NULL
		)

GO

	CREATE TABLE BILET(
		BiletId INT IDENTITY(1,1) PRIMARY KEY,
		Ucret MONEY NOT NULL,
		KesilmeTarih DATE NOT NULL,
		KoltukNo SMALLINT CONSTRAINT uniqueBiletKoltuk UNIQUE 
						  CONSTRAINT notNullBiletKoltuk NOT NULL,
		CheckInDurum BIT DEFAULT 0, -- 0 ya da bir olur check-in islemi yapildiysa 1 olarak ayarlanir
		CheckInDate DATE,
		Firma INT FOREIGN KEY REFERENCES FIRMA(FirmaId)
							  CONSTRAINT noNullBiletFirma NOT NULL,
		Sube INT FOREIGN KEY REFERENCES SUBE(SubeId)
							 CONSTRAINT noNullBiletSube	NOT NULL,
		BiletKesen INT FOREIGN KEY REFERENCES PERSONEL(PersonelId)
								   CONSTRAINT notNullBiletKesen NOT NULL,
		Yolcu INT FOREIGN KEY REFERENCES YOLCU(YolcuId)
							  CONSTRAINT notNullBiletYolcu NOT NULL
							  CONSTRAINT chkUniqueBiletYolcu UNIQUE,
		Guzergah INT FOREIGN KEY REFERENCES GUZERGAH(GuzergahId)
							     CONSTRAINT chkNullBiletGuzergah NOT NULL,
		Sefer INT FOREIGN KEY REFERENCES SEFER(SeferId)
							  CONSTRAINT notNullBiletSefer NOT NULL,
		BinisDurak INT FOREIGN KEY REFERENCES UGRANILAN_DURAK_SEFER(UgranilanDurakId)
								   CONSTRAINT notNullBiletBinis NOT NULL,
		InisDurak INT FOREIGN KEY REFERENCES UGRANILAN_DURAK_SEFER(UgranilanDurakId)
								  CONSTRAINT notNullBiletInis NOT NULL,
		Arac INT FOREIGN KEY REFERENCES FIRMA_ARAC(FirmaAracId)
								  CONSTRAINT notNullBiletArac NOT NULL

	)