SELECT FIRMA.*,IL.IlAdi,ILCE.IlceAdi FROM
FIRMA, IL, ILCE
WHERE FIRMA.FirmaId=1 AND IL.IlKodu = FIRMA.FirmaIlKodu AND ILCE.IlceId = FIRMA.FirmaIlceKodu

SELECT TOP 10 * FROM IL
SELECT TOP 10 * FROM ILCE 

SELECT F.*, I.IlAdi, IC.IlceAdi FROM
FIRMA F, IL I, ILCE IC
WHERE F.FirmaId = 1 AND I.IlKodu = F.FirmaIlKodu AND IC.IlceId = F.FirmaIlceKodu

SELECT F.FirmaAd, F.WebAdresi, F.FirmaAdres, F.KurulusTarih, F.TelNo, I.IlAdi, IC.IlceAdi FROM
FIRMA F
JOIN IL I ON I.IlKodu = F.FirmaIlKodu 
JOIN ILCE IC ON IC.IlceId = F.FirmaIlceKodu

SELECT I.IlAdi, COUNT(F.FirmaId) AS IlBazliFirmaSayisi FROM
FIRMA F
JOIN IL I ON I.IlKodu = F.FirmaIlKodu
GROUP BY I.IlAdi

SELECT F.FirmaAd, I.IlAdi FROM
FIRMA F
JOIN IL I ON I.IlKodu = F.FirmaIlKodu

SELECT * FROM FIRMA

SELECT I.IlAdi, IC.IlceAdi, COUNT(F.FirmaId) AS IlceBazliFirmaSayisi FROM
FIRMA F
JOIN IL I ON I.IlKodu = F.FirmaIlKodu
JOIN ILCE IC ON IC.IlceId = F.FirmaIlceKodu
GROUP BY I.IlAdi, IC.IlceAdi

--join = inner join

SELECT F.FirmaAd, S.SubeAd FROM
SUBE S
RIGHT JOIN FIRMA F ON F.FirmaId =  S.SubeFirma

SELECT F.FirmaAd, S.SubeAd FROM
SUBE S
LEFT JOIN FIRMA F ON F.FirmaId =  S.SubeFirma

SELECT M.MarkaAd, AM.ModelAd FROM
MARKA M
LEFT JOIN ARAC_MODEL AM ON M.MarkaId = AM.MarkaId

SELECT M.MarkaAd, AM.ModelAd FROM
MARKA M
RIGHT JOIN ARAC_MODEL AM ON M.MarkaId = AM.MarkaId

SELECT M.MarkaAd, AM.ModelAd FROM
ARAC_MODEL AM
RIGHT JOIN MARKA M ON M.MarkaId = AM.MarkaId

SELECT M.MarkaAd, AM.ModelAd FROM
ARAC_MODEL AM
LEFT JOIN MARKA M ON M.MarkaId = AM.MarkaId

select * from firma
select * from sube
select * from marka
select * from arac_model

SELECT COUNT(Y.YolcuId) 
FROM YOLCU Y
GROUP BY Y.Cinsiyet 

SELECT COUNT(Y.YolcuId), Y.Ad, Y.Soyad, Y.Cinsiyet
FROM BILET B
JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
GROUP BY Y.Cinsiyet, Y.Ad, Y.Soyad

SELECT COUNT(Y.YolcuId), Y.Ad, Y.Soyad
FROM YOLCU Y
JOIN BILET B ON Y.YolcuId = B.Yolcu
GROUP BY Y.Cinsiyet, Y.Ad, Y.Soyad

SELECT COUNT(Y.YolcuId), I.IlAdi, Y.Cinsiyet
FROM BILET B
JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
JOIN IL I ON I.IlKodu = D.DurakIlId
GROUP BY I.IlAdi, Y.Cinsiyet

SELECT I.IlAdi, Y.Cinsiyet, COUNT(Y.YolcuId) AS CinsiyetSayi
FROM BILET B
	INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
	INNER JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
	INNER JOIN IL I ON I.IlKodu = D.DurakIlId
GROUP BY I.IlAdi, Y.Cinsiyet

SELECT TOP 3 COUNT(B.Firma) As BiletSayisi, F.FirmaAd, F.FirmaId
FROM BILET B
	INNER JOIN FIRMA F ON F.FirmaId = B.Firma
GROUP BY F.FirmaAd, F.FirmaId
ORDER BY BiletSayisi DESC

-- nihai versiyon
SELECT I.IlAdi,
	  SUM(CASE WHEN Y.Cinsiyet = 'E' THEN 1 ELSE 0 END) AS ErkekSayisi,
	  SUM(CASE WHEN Y.Cinsiyet = 'K' THEN 1 ELSE 0 END) AS KadinSayisi
FROM BILET B
	INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
	INNER JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
	INNER JOIN IL I ON I.IlKodu = D.DurakIlId
	INNER JOIN SEFER S ON S.SeferId = B.Sefer 
	INNER JOIN (SELECT TOP 3 COUNT(B.Firma) As BiletSayisi, F.FirmaAd, F.FirmaId
				FROM BILET B
				INNER JOIN FIRMA F ON F.FirmaId = B.Firma
				GROUP BY F.FirmaAd, F.FirmaId) X ON X.FirmaId = B.Firma
	INNER JOIN (SELECT S.Firma
				FROM SEFER S
				INNER JOIN BILET B ON S.SeferId = B.Sefer
				WHERE MONTH(S.KalkisTarih) = MONTH(GETDATE())
				GROUP BY S.Firma
				HAVING COUNT(B.Yolcu) > 2) Z ON Z.Firma=  X.FirmaId
WHERE MONTH(GETDATE()) - MONTH(S.KalkisTarih) = 1 AND YEAR(GETDATE()) = YEAR(S.KalkisTarih)
GROUP BY I.IlAdi

select * from SEFER
SELECT * FROM BILET

select I.IlAdi, Y.Ad, Y.Soyad, Y.Cinsiyet, F.FirmaAd, S.KalkisTarih from BILET B
INNER JOIN DURAKLAR D ON D.DurakId = B.BinisDurak
INNER JOIN IL I ON I.IlKodu = D.DurakIlId
INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
INNER JOIN SEFER S ON S.SeferId = B.Sefer
INNER JOIN FIRMA F ON F.FirmaId = B.Firma


select * from BILET

SELECT I.IlAdi, X.FirmaAd, 
		SUM(CASE WHEN Y.Cinsiyet = 'E' THEN 1 ELSE 0 END) AS ErkekSayisi,
		SUM(CASE WHEN Y.Cinsiyet = 'K' THEN 1 ELSE 0 END) AS KadinSayisi
FROM BILET B
INNER JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
INNER JOIN IL I ON I.IlKodu = D.DurakIlId
INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
INNER JOIN (SELECT TOP 3 COUNT(B.Firma) As BiletSayisi, F.FirmaAd, F.FirmaId
				FROM BILET B
					INNER JOIN FIRMA F ON F.FirmaId = B.Firma
				GROUP BY F.FirmaAd, F.FirmaId) X ON X.FirmaId = B.Firma
INNER JOIN (SELECT B.Firma
			FROM BILET B
			INNER JOIN SEFER S ON S.SeferId = B.Sefer
			WHERE S.KalkisTarih = GETDATE()
			GROUP BY B.Firma) Z ON Z.Firma= X.FirmaId
GROUP BY I.IlAdi, X.FirmaAd, Y.Cinsiyet


SELECT MONTH(GETDATE()), MONTH(S.KalkisTarih) 
FROM BILET B
INNER JOIN SEFER S ON B.Sefer = S.SeferId

SELECT I.IlAdi, Y.Cinsiyet, COUNT(Y.YolcuId) AS CinsiyetSayi, S.KalkisTarih
FROM BILET B
	INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
	INNER JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
	INNER JOIN IL I ON I.IlKodu = D.DurakIlId
	INNER JOIN SEFER S ON S.SeferId = B.Sefer 
	INNER JOIN (SELECT TOP 3 COUNT(B.Firma) As BiletSayisi, F.FirmaAd, F.FirmaId
				FROM BILET B
					INNER JOIN FIRMA F ON F.FirmaId = B.Firma
				GROUP BY F.FirmaAd, F.FirmaId) X ON X.FirmaId = B.Firma

GROUP BY I.IlAdi, Y.Cinsiyet, S.KalkisTarihi

WHERE MONTH(GETDATE()) - MONTH(S.KalkisTarih) = 1 AND YEAR(GETDATE()) = YEAR(S.KalkisTarih) AND X.FirmaId = 1

SELECT I.IlAdi, Y.Cinsiyet, COUNT(Y.YolcuId) AS CinsiyetSayi, S.KalkisTarih
FROM BILET B
	INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
	INNER JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
	INNER JOIN IL I ON I.IlKodu = D.DurakIlId
	INNER JOIN SEFER S ON S.SeferId = B.Sefer 
	INNER JOIN (SELECT TOP 3 COUNT(B.Firma) As BiletSayisi, F.FirmaAd, F.FirmaId
				FROM BILET B
					INNER JOIN FIRMA F ON F.FirmaId = B.Firma
				GROUP BY F.FirmaAd, F.FirmaId) X ON X.FirmaId = B.Firma

GROUP BY I.IlAdi, Y.Cinsiyet, S.KalkisTarih




select * from BILET
select * from yolcu
select * from duraklar
select * from sefer

SELECT I.IlAdi,
	  SUM(CASE WHEN Y.Cinsiyet = 'E' THEN 1 ELSE 0 END) AS ErkekSayisi,
	  SUM(CASE WHEN Y.Cinsiyet = 'K' THEN 1 ELSE 0 END) AS KadinSayisi
FROM BILET B
	INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
	INNER JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
	INNER JOIN IL I ON I.IlKodu = D.DurakIlId
	INNER JOIN SEFER S ON S.SeferId = B.Sefer 
	INNER JOIN (SELECT TOP 3 COUNT(B.Firma) As BiletSayisi, F.FirmaAd, F.FirmaId
				FROM BILET B
				INNER JOIN FIRMA F ON F.FirmaId = B.Firma
				GROUP BY F.FirmaAd, F.FirmaId) X ON X.FirmaId = B.Firma
	INNER JOIN (SELECT  Y.YolcuId, S.Firma
				FROM BILET B
				INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
				INNER JOIN SEFER S ON  S.SeferId = B.Sefer
				WHERE MONTH(S.KalkisTarih) = MONTH(GETDATE())
				GROUP BY S.Firma, Y.YolcuId
				HAVING COUNT(B.Yolcu) > 1) Z ON Z.Firma=  X.FirmaId
WHERE MONTH(GETDATE()) - MONTH(S.KalkisTarih) = 1 AND YEAR(GETDATE()) = YEAR(S.KalkisTarih)
GROUP BY I.IlAdi



SELECT 
  Y.TCNo,
  Y.Ad,
  Y.Soyad,
  Y.TelefonNo
FROM BILET B
INNER JOIN YOLCU Y ON B.Yolcu = Y.YolcuId
INNER JOIN FIRMA F ON B.Firma = F.FirmaId
INNER JOIN SEFER S ON B.Sefer = S.SeferId
INNER JOIN DURAKLAR BD ON BD.DurakId = B.BinisDurak
INNER JOIN DURAKLAR ID ON ID.DurakId = B.InisDurak

WHERE 
  F.FirmaAd = 'Pamukkale Seyehat' AND
  MONTH(S.KalkisTarih) = MONTH(GETDATE()) AND
  ((BD.DurakIlId = '06' AND ID.DurakIlId = '34') OR
   (BD.DurakIlId = '35' AND ID.DurakIlId = '34'))
ORDER BY
  Y.TCNo

  SELECT * FROM SEFER
  SELECT * FROM FIRMA

  
select I.IlAdi, Y.Ad, Y.Soyad, Y.Cinsiyet, F.FirmaAd, S.KalkisTarih from BILET B
INNER JOIN DURAKLAR D ON D.DurakId = B.BinisDurak
INNER JOIN IL I ON I.IlKodu = D.DurakIlId
INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
INNER JOIN SEFER S ON S.SeferId = B.Sefer
INNER JOIN FIRMA F ON F.FirmaId = B.Firma

  select * from BILET
  select * from DURAKLAR