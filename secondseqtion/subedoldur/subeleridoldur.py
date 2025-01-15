import pandas as pd
import random as rnd


ilceler_tablosu = pd.read_excel('ilce-listesi.xlsx')

subeler_tablosu = pd.read_excel('sube.xlsx')

firmalar_tablosu = pd.read_excel('firmalar.xlsx')

ilce_kod_sozluk = []

firma_isimleri = []

for _, row in ilceler_tablosu.iterrows():
    ilce_kod_sozluk.append(row.values)

for _, row in firmalar_tablosu.iterrows():
    firma_isim = row['Firma_Adi']
    if len(str(firma_isim).split()) > 1:
        firma_isim = str(firma_isim).split()
        firma_isim = firma_isim[0] + " " + firma_isim[1]
    if firma_isim not in firma_isimleri:
        firma_isimleri.append(firma_isim)



# firma kirktan baslayarak artacak
counter = 1

for i in range(1,515):
    for j in range(1,101):
        subeAdres = ilce_kod_sozluk[rnd.randint(0,995)]
        subeIlKodu = subeAdres[0]
        subeIlAdi = str(subeAdres[2])
        subeIlceKodu = subeAdres[3]
        subeIlceAdi = str(subeAdres[1])
        subeler_tablosu.loc[counter,"SubeAd"] = firma_isimleri[i-1] + " " + subeIlAdi + " " + subeIlceAdi + " Subesi"
        subeler_tablosu.loc[counter,"SubeAdres"] = subeIlAdi.capitalize() + " " + subeIlceAdi.capitalize()
        subeler_tablosu.loc[counter,"TelNo"] = str(rnd.randint(3124534156,4801801341))
        subeler_tablosu.loc[counter,"TelNo2"] = str(rnd.randint(5328731040,5521801341))
        subeler_tablosu.loc[counter,'SubeIl'] = subeIlKodu
        subeler_tablosu.loc[counter,"SubeIlce"] = subeIlceKodu
        subeler_tablosu.loc[counter,"SubeFirma"] = i + 39
        counter+=1


subeler_tablosu.to_excel('subeler_guncel2.xlsx',index=False)


