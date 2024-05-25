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
	INNER JOIN (SELECT TOP 3 COUNT(B.Firma) As BiletSayisi, F.FirmaAd, F.FirmaId
				FROM BILET B
				INNER JOIN FIRMA F ON F.FirmaId = B.Firma
				GROUP BY F.FirmaAd, F.FirmaId) X ON X.FirmaId = B.Firma
WHERE MONTH(S.KalkisTarih) = MONTH(GETDATE())
  AND YEAR(S.KalkisTarih) = YEAR(GETDATE())
  AND B.Yolcu IN (
      SELECT B1.Yolcu
      FROM BILET B1
      INNER JOIN SEFER S1 ON S1.SeferId = B1.Sefer
      WHERE S1.Firma = B.Firma
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
	Y.TCNo,
	Y.Ad,
	Y.Soyad,
	Y.TelefonNo
FROM BILET B
	INNER JOIN YOLCU Y ON B.Yolcu = Y.YolcuId
	INNER JOIN FIRMA F ON B.Firma = F.FirmaId
	INNER JOIN SEFER S ON B.Sefer = S.SeferId
	INNER JOIN UGRANILAN_DURAK_SEFER BD ON BD.DurakId = B.BinisDurak
	INNER JOIN UGRANILAN_DURAK_SEFER ID ON ID.DurakId = B.InisDurak

WHERE 
  F.FirmaAd = 'Pamukkale Seyahat' AND
  MONTH(S.KalkisTarih) = MONTH(GETDATE()) AND
  ((BD.DurakIl = '06' AND ID.DurakIl = '34') OR
   (BD.DurakIl = '35' AND ID.DurakIl = '34'))
ORDER BY
  Y.TCNo

