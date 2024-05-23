USE BILETSATIS
--baþalngýç ve bitiþ tarihinde hata veriyor execute etmiyor. personel-pozisyon iliþkisini kodda düzelt.

INSERT INTO PERSONEL
(TCNo, Ad, Soyad, DOGUMTARIHI, CINSIYET, MEDENIHAL, TelefonNo, EPosta,BaslangicTarih, AyrilmaTarih, DogumIl, DogumIlce, POZSIYON, FIRMA, Sube)
VALUES
('12345678910','Ali','Yýlmaz','1984-12-11','E','B','5432123132','aliyilmaz@posta.com','2021-12-03',NULL,'34',443,1,1,6),
('12345678914','Veli','Durmaz','1981-11-10','E','E','5432183132','velidurmaz@posta.com','2023-01-13',NULL,'34',449,2,2,8),
('12345678912','Zeynep','Bakan','1983-01-21','K','B','5432123133','zeynepbakan@posta.com','2004-08-25',NULL,'34',435,3,2,11),
('12345678916','Fatma','Güneþ','1984-08-13','K','E','5432123134','fatmagunes@posta.com','2016-07-14',NULL,'34',454,4,1,3),
('55243065224','Saliha Kübra','Topaloðlu','2002-08-06','K','E','5511523155','kubraozkul0@posta.com','2021-12-03',NULL,'34',455,8,4,14),
('55243065222','Çetin','Özkul','1972-09-01','E','E','5364104315','cetinozkul@posta.com','2010-12-12',NULL,'55',761,12,1,4),
('55243065220','Hakký','Bulut','1980-12-10','E','B','5511523156','hakkibulut@posta.com','2020-01-01',NULL,'81',989,1,39,18),
('55243065226','Beyzanur','Polat','2001-11-11','K','B','5511523157','beyzanurpolat@posta.com','2023-12-03',NULL,'41',569,3,39,20),
('55243065228','Müzeyyen','Candan','1985-05-05','K','E','5511523158','muzeycandan@posta.com','2009-12-03',NULL,'52',716,3,4,15),
('55243065124','Sebahattin','Alan','1981-12-11','E','E','5511523159','sebaalan@posta.com','2019-01-01',NULL,'52',715,9,1,6),
('55243065024','Özge Can','Özkul','1999-05-05','K','B','5511523177','ozgecan@posta.com','2009-12-03',NULL,'52',716,3,4,15),
('55243065022','Emine','Özkul','1980-09-01','K','E','5364104314','emineozkul@posta.com','2010-12-12',NULL,'55',761,4,40,25),
('55253065220','Muhammet Yasin','Özkul','2002-09-01','E','B','5364104313','muhammetozkul@posta.com','2024-01-12',NULL,'34',455,4,40,28),
('55253065226','Samet','Kara','1999-09-01','E','B','5364104312','sametkara@posta.com','2023-01-05',NULL,'81',989,5,40,29),
('55293065228','Erkan','Kara','1997-09-01','E','B','5364104311','erkankara@posta.com','2023-05-05',NULL,'81',989,4,40,29),
('55273055522','Tuðçe','Top','1996-06-01','K','B','5364104310','tugcetop@posta.com','2024-02-01',NULL,'41',569,5,40,25)
