USE BILETSATIS
/*
Ge�en ay (sistem tarihine g�re otomatik al�nacakt�r) en �ok yolcu ta��yan ilk �� firman�n
hepsiyle bu ay i�inde en az iki kez seyahat etmi� yolcular�n il baz�nda erkek ve kad�n say�lar�
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
Bu ay i�inde PAMUKKALE firmas�ndan hem Ankara-�stanbul hem de �zmir-�stanbul otob�s bileti alan yolcular�n
tcno, ad, soyad, tel bilgileri (dikkat : �nemli olan g�zergah ba�lang��-biti� noktalar� de�il biletin ba�lang��-biti� noktas�)
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

