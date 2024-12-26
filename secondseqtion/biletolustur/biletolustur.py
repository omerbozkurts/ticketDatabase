import pandas as pd
import random as rnd

personel_firma_sube_tablosu = pd.read_excel("personel.xlsx")
bilet_tablosu = pd.read_excel("bilet.xlsx")

personel_firma_subeler = []

for _,row in personel_firma_sube_tablosu.iterrows():
    personel_firma_subeler.append(row.values)

bilet_tablosu["KesilmeTarih"] = pd.to_datetime(bilet_tablosu["KesilmeTarih"], errors='coerce')

for i in range(0,15000):
    pfs_random = personel_firma_subeler[rnd.randint(0,432)]
    firma = pfs_random[0]
    sube = pfs_random[1]
    personel = pfs_random[2]
    bilet_tablosu.loc[i,"Ucret"] = rnd.randint(500,1400)
    bilet_tablosu.loc[i,"KesilmeTarih"] = str(rnd.randint(2022,2024)) + "-" + str(rnd.randint(1,12)) + "-" + str(rnd.randint(1,28))
    bilet_tablosu.loc[i,"KoltukNo"] = rnd.randint(1,50)
    bilet_tablosu.loc[i,"Firma"] = firma
    bilet_tablosu.loc[i,"Sube"] = sube
    bilet_tablosu.loc[i,"BiletKesen"] = personel
    bilet_tablosu.loc[i,"Yolcu"] = rnd.randint(1,1000)
    bilet_tablosu.loc[i,"Guzergah"] = rnd.randint(1,12)
    bilet_tablosu.loc[i,"Sefer"] = rnd.randint(0,144)
    bilet_tablosu.loc[i,"BinisDurak"] = rnd.randint(0,24)
    bilet_tablosu.loc[i,"InisDurak"] = rnd.randint(0,24)
    bilet_tablosu.loc[i,"Arac"] = rnd.randint(0,46)


bilet_tablosu.to_excel("bilet_yeni.xlsx")

