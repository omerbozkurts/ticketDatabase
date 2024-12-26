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
SELECT I.IlAdi, Y.Cinsiyet, COUNT(Y.YolcuId) AS CinsiyetSayi
FROM BILET B
	INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
	INNER JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
	INNER JOIN IL I ON I.IlKodu = D.DurakIlId
	INNER JOIN SEFER S ON S.SeferId = B.Sefer 
	INNER JOIN (SELECT TOP 3 COUNT(B.Firma) As BiletSayisi, F.FirmaAd, F.FirmaId
				FROM BILET B
					INNER JOIN FIRMA F ON F.FirmaId = B.Firma
				GROUP BY F.FirmaAd, F.FirmaId) X ON X.FirmaId = B.Firma
WHERE MONTH(GETDATE()) - MONTH(S.KalkisTarih) = 1 AND YEAR(GETDATE()) = YEAR(S.KalkisTarih) AND (B.Firma = 1 AND B.Firma = 2 AND B.Firma =3)
GROUP BY I.IlAdi, Y.Cinsiyet

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