USE BILETSATIS
INSERT INTO FIRMA 
(FirmaAd, WebAdresi, FirmaAdres, KurulusTarih, TelNo, TelNo2, TelNo3, FirmaIlKodu,FirmaIlceKodu) 
VALUES --TELNO2 ve TELNO3 degerleri istege bagli olarak verilebilmektedir
--otobüs
('Yalova Seyahat','www.yalovaseyahat.com.tr','Yalova Merkez','2008-08-07','2161514777',NULL, NULL,'77',971)
('Pamukkale Seyehat','www.pamukkale.com','pamukkale merkez','2014-03-02','5431231010',NULL,NULL,'20',253), 
('Tokat Seyehat','www.tokatseyehat.com','tokat zile','2011-09-12','5431241918',NULL,NULL,'60',822),
('Metro Turizm', 'www.metroturizm.com.tr', 'Ýstanbul Kadýköy', '2003-05-12', '4440344897', NULL, NULL, '34',460),
('Kamil Koç', 'www.kamilkoc.com.tr', 'Ankara Çankaya', '1926-06-01', '4440562777', '4440563777', NULL, '06', 77),
('Uludağ Turizm', 'www.uludag.com.tr', 'Bursa Nilüfer', '1951-09-18', '2242943434', '2242943435', NULL, '16', 198),
('Yeşil Doğa', 'www.yesildoga.com.tr', 'Bolu Merkez', '2008-08-05', '3742164242', NULL, NULL, '14', 182),
('Turuncu Yol', 'www.turuncuyol.com.tr', 'Samsun Merkez', '2015-11-28', '3623261515', NULL, NULL, '55', 766),
('Akbil', 'www.akbil.com.tr', 'Erzurum Merkez', '1995-09-03', '4422321234', NULL, NULL, '25', 334),
('Şimşek Turizm', 'www.simsekturizm.com.tr', 'Van Merkez', '2018-07-22', '4322123434', NULL, NULL, '65', 883),
('Yıldırım Seyahat', 'www.yildirimseyahat.com.tr', 'Kocaeli Merkez', '2005-02-17', '2623174040', NULL, NULL, '41', 568),
('Zirve Tur', 'www.zirvetur.com.tr', 'Diyarbakır Merkez', '2013-09-19', '4122289876', NULL, NULL, '21', 281),
('Pusula Tur', 'www.pusulatur.com.tr', 'Çorum Merkez', '2010-08-08', '3642135757', NULL, NULL, '19', 246),
('Sarıçam Seyahat', 'www.saricamseyahat.com.tr', 'Sakarya Merkez', '2016-04-05', '2643289999', NULL, NULL, '54', 749),

--gemi
('Sarı Sahil', 'www.sarisahil.com.tr', 'Trabzon Merkez', '2010-02-13', '4623213351', NULL, NULL, '61', 840),--GEMİ
('Beyaz Kumsal', 'www.beyazkumsal.com.tr', 'Antalya Merkez', '2013-06-30', '2423249061', NULL, NULL, '07', 100),--GEMİ
('Turkuaz Göller', 'www.turkuazgoller.com.tr', 'Isparta Merkez', '2016-05-17', '2462322372', NULL, NULL, '32', 413),--GEMİ
('Mor Dağlar', 'www.mordaglar.com.tr', 'Rize Merkez', '2019-04-24', '4642235131', NULL, NULL, '53', 730),--GEMİ
('Gümüş Deniz', 'www.gumusdeniz.com.tr', 'İzmir Karşıyaka', '2007-04-19', '2323257878', NULL, NULL, '35', 492),--GEMİ
('Mavi Rüzgar', 'www.maviruzgar.com.tr', 'Balıkesir Merkez', '2012-03-14', '2662236611', NULL, NULL, '10', 149),--GEMİ
('Ege Denizi', 'www.egedenizi.com.tr', 'Çanakkale Merkez', '2003-08-18', '2862212121', NULL, NULL, '17', 217),
('Turuncu Gemi', 'www.turuncugemi.com.tr', 'Trabzon Merkez', '2008-11-05', '4623241515', NULL, NULL, '61', 840),
('Akdeniz Yelken', 'www.akdenizyelken.com.tr', 'Antalya Merkez', '2005-06-10', '2423242323', NULL, NULL, '07', 100),
('Güney Rüzgarı', 'www.guneyruzgari.com.tr', 'Mersin Merkez', '2012-09-14', '3243171313', NULL, NULL, '33', 427),
('Mavi Deniz', 'www.mavideniz.com.tr', 'Edirne Merkez', '2019-01-20', '2842287878', NULL, NULL, '22', 295),
('Kuzey Fırtınası', 'www.kuzeyfirtinasi.com.tr', 'Rize Merkez', '2007-01-15', '4642239090', NULL, NULL, '53', 730),
('Karadeniz Gemi', 'www.karadenizgemi.com.tr', 'Giresun Merkez', '2015-06-18', '4543239090', NULL, NULL, '28', 372),

--tren
('Güneş Express', 'www.gunesexpress.com.tr', 'Mersin Merkez', '2011-03-30', '3243171515', NULL, NULL, '33', 427),
('Köprü Express', 'www.kopruexpress.com.tr', 'Adana Merkez', '2001-12-08', '3223278989', NULL, NULL, '01', 1),--
('Uçan Kartal', 'www.ucankartal.com.tr', 'Ağrı Merkez', '2014-10-11', '4722256767', NULL, NULL, '04', 50),
('Deniz Gök', 'www.denizgok.com.tr', 'Muğla Merkez', '2009-06-25', '2523168888', NULL, NULL, '48', 649),
('Karadeniz Express', 'www.karadenizexpress.com.tr', 'Ordu Merkez', '2017-12-24', '4523281010', NULL, NULL, '52', 718),
('Doğu Ekspres', 'www.doguekspres.com.tr', 'Erzurum Merkez', '2014-02-28', '4423229898', NULL, NULL, '25', 334),

--uçak
('Türk Hava Yolları (THY)', 'www.turkishairlines.com', ' Bakırköy/İstanbul', '1933-05-20', '0212567890', '0212567891', '0212567892', '34', 469),--OTOBUS
('Büyük Turizm', 'www.buyukturizm.com.tr', 'Sivas Merkez', '1998-04-02', '3462327878', NULL, NULL, '58', 798),
('Yıldız Yolları', 'www.yildizyollari.com.tr', 'Tekirdağ Merkez', '2004-07-13', '2822129898', NULL, NULL, '59', 810),
('Kuzey Yıldızı', 'www.kuzeyyildizi.com.tr', 'Kastamonu Merkez', '2002-10-30', '3662226767', NULL, NULL, '37', 519),
('Rüzgar hava yolları', 'www.ruzgarhv.com.tr', 'Hatay Merkez', '2006-11-11', '3262212828', NULL, NULL, '31', 400),
('Atlas hava yolları', 'www.atlasseyahat.com.tr', 'Afyonkarahisar Merkez', '2000-05-15', '2722166666', NULL, NULL, '03', 42),
('Batı Yıldızı', 'www.batiyildizi.com.tr', 'İzmir Foça', '2019-05-30', '2323284545', NULL, NULL, '35', 494)



