USE BILETSATIS
/*
Geçen ay (sistem tarihine göre otomatik alýnacaktýr) en çok yolcu taþýyan ilk üç firmanýn
hepsiyle bu ay içinde en az iki kez seyahat etmiþ yolcularýn il bazýnda erkek ve kadýn sayýlarý
*/
SELECT I.IlAdi,
       SUM(CASE WHEN Y.Cinsiyet = 'E' THEN 1 ELSE 0 END) AS ErkekSayisi,
       SUM(CASE WHEN Y.Cinsiyet = 'K' THEN 1 ELSE 0 END) AS KadinSayisi
FROM BILET B
INNER JOIN YOLCU Y ON Y.YolcuId = B.Yolcu
INNER JOIN DURAKLAR D ON B.BinisDurak = D.DurakId
INNER JOIN IL I ON I.IlKodu = D.DurakIlId
INNER JOIN SEFER S ON S.SeferId = B.Sefer
WHERE 
      B.Firma IN (
        SELECT TOP 3 B2.Firma
        FROM BILET B2
        INNER JOIN SEFER S2 ON S2.SeferId = B2.Sefer
        WHERE 
            MONTH(S2.KalkisTarih) = MONTH( GETDATE())
            AND YEAR(S2.KalkisTarih) = YEAR(GETDATE())
        GROUP BY B2.Firma
        ORDER BY COUNT(*) DESC
      )
	  AND
	  B.Yolcu IN (
		SELECT B1.Yolcu
      FROM BILET B1
      INNER JOIN SEFER S1 ON S1.SeferId = B1.Sefer
      WHERE S1.Firma = B1.Firma
      AND MONTH(S1.KalkisTarih) = MONTH(GETDATE())
      AND YEAR(S1.KalkisTarih) = YEAR(GETDATE())
      GROUP BY B1.Yolcu
      HAVING COUNT(B1.Yolcu) > 1
	  )
	  
GROUP BY I.IlAdi

/*
Bu ay içinde PAMUKKALE firmasýndan hem Ankara-Ýstanbul hem de Ýzmir-Ýstanbul otobüs bileti alan yolcularýn
tcno, ad, soyad, tel bilgileri (dikkat : önemli olan güzergah baþlangýç-bitiþ noktalarý deðil biletin baþlangýç-bitiþ noktasý)
*/

SELECT 
	Y.YolcuId,
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
  F.FirmaAd = 'Pamukkale Seyahat' AND
  MONTH(S.KalkisTarih) = MONTH(GETDATE()) AND
  ((BD.DurakIlId = '06' AND ID.DurakIlId = '34') OR
   (BD.DurakIlId = '35' AND ID.DurakIlId = '34')) 
ORDER BY
  Y.TCNo





SELECT DISTINCT
	Y.YolcuId,
	Y.TCNo,
	Y.Ad,
	Y.Soyad,
	Y.TelefonNo

FROM YOLCU Y

INNER JOIN BILET B1 ON B1.Yolcu = Y.YolcuId 
INNER JOIN BILET B2 ON B2.Yolcu = Y.YolcuId
INNER JOIN FIRMA F1 ON B1.Firma = F1.FirmaId
INNER JOIN FIRMA F2 ON B2.Firma = F2.FirmaId
INNER JOIN SEFER S1 ON S1.SeferId = B1.Sefer
INNER JOIN SEFER S2 ON S2.SeferId = B2.Sefer
INNER JOIN DURAKLAR BD1 ON BD1.DurakId = B1.BinisDurak
INNER JOIN DURAKLAR ID1 ON ID1.DurakId = B1.InisDurak
INNER JOIN DURAKLAR BD2 ON BD2.DurakId = B2.BinisDurak
INNER JOIN DURAKLAR ID2 ON ID2.DurakId = B2.InisDurak


WHERE F1.FirmaAd = 'Pamukkale Seyahat' AND F2.FirmaAd = 'Pamukkale Seyahat' AND  
MONTH(S1.KalkisTarih) = MONTH(GETDATE()) AND MONTH(S2.KalkisTarih) = MONTH(GETDATE()) AND
((BD1.DurakIlId = '06' AND ID1.DurakIlId = '34') AND (BD2.DurakIlId = '35' AND ID2.DurakIlId = '34'))

	 


SELECT 
	Y.YolcuId,
	Y.TCNo,
	Y.Ad,
	Y.Soyad,
	Y.TelefonNo
FROM YOLCU Y
	INNER JOIN (SELECT Yolcu FROM YOLCU FY
				INNER JOIN BILET B1 ON B1.Yolcu = FY.YolcuId 		
				INNER JOIN FIRMA F1 ON B1.Firma = F1.FirmaId		
				INNER JOIN SEFER S1 ON S1.SeferId = B1.Sefer		
				INNER JOIN DURAKLAR BD1 ON BD1.DurakId = B1.BinisDurak
				INNER JOIN DURAKLAR ID1 ON ID1.DurakId = B1.InisDurak
		WHERE F1.FirmaAd = 'Pamukkale Seyahat' AND
		MONTH(S1.KalkisTarih) = MONTH(GETDATE()) AND
		(BD1.DurakIlId = '06' AND ID1.DurakIlId = '34') 
		) FY ON FY.Yolcu = Y.YolcuId
	INNER JOIN BILET B2 ON B2.Yolcu = Y.YolcuId
	INNER JOIN FIRMA F2 ON B2.Firma = F2.FirmaId
	INNER JOIN SEFER S2 ON B2.Sefer = S2.SeferId
	INNER JOIN DURAKLAR BD2 ON BD2.DurakId = B2.BinisDurak
	INNER JOIN DURAKLAR ID2 ON ID2.DurakId = B2.InisDurak

WHERE 
  F2.FirmaAd = 'Pamukkale Seyahat' AND
  MONTH(S2.KalkisTarih) = MONTH(GETDATE()) AND
  (BD2.DurakIlId = '35' AND ID2.DurakIlId = '34') 

ORDER BY
  Y.TCNo


 
