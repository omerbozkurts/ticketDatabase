import random as rnd
import pandas as pd


erkek_isimler_tablosu = pd.read_excel('erkek_isim.xlsx')
kadin_isimler_tablosu = pd.read_excel('kadin_isim.xlsx')
soyisimler_tablosu = pd.read_excel('soyisimler.xlsx')
ilceler_tablosu = pd.read_excel('ilce-listesi.xlsx')
personel_isim_tablosu = pd.read_excel('personel_isim.xlsx')
subeler_firmalar_tablosu = pd.read_excel('sube.xlsx')


ilce_kod_sozluk = []
erkek_isimler = []
kadin_isimler = []
soyisimler_liste = []
isim_soyisim_dahil = []
subeler_firmalar = []

for _, row in ilceler_tablosu.iterrows():
    ilce_kod_sozluk.append(row.values)


for _, row in erkek_isimler_tablosu.iterrows():
    erkek_isimler.append(row.values)

for _, row in kadin_isimler_tablosu.iterrows():
    kadin_isimler.append(row.values)

for _, row in soyisimler_tablosu.iterrows():
    soyisimler_liste.append(row.values)

for _, row in subeler_firmalar_tablosu.iterrows():
    if _ % 6 == 0:
        subeler_firmalar.append(row.values)

for i in range(0,100000):
    SahisIsim = None
    SahisSoyisim = None
    personel_isim_tablosu.loc[i,"TCNO"] = str(rnd.randint(12345678919,98765432191))
    if i%2 == 0:
        personel_isim_tablosu.loc[i,"Cinsiyet"] = "E"
        SahisIsim = str(erkek_isimler[rnd.randint(0,1320)][0]).capitalize()
        personel_isim_tablosu.loc[i,"Ad"] = SahisIsim
    elif i%2 == 1:
         personel_isim_tablosu.loc[i,"Cinsiyet"] = 'K'
         SahisIsim = str(kadin_isimler[rnd.randint(0,1410)][0]).capitalize()
         personel_isim_tablosu.loc[i,"Ad"] = SahisIsim
    SahisSoyisim = str(soyisimler_liste[rnd.randint(0,2435)][0]).capitalize()
    personel_isim_tablosu.loc[i,"Soyad"] = SahisSoyisim
    randBirthDate = str(rnd.randint(1,28)) + "." + str(rnd.randint(1,12)) + "." + str(rnd.randint(1960,1990))
    personel_isim_tablosu.loc[i,"DogumTarihi"] = str(randBirthDate)
    listB = ['E','B']
    personel_isim_tablosu.loc[i,"MedeniHal"] = str(rnd.choice(listB))
    personel_isim_tablosu.loc[i,"TelefonNo"] = str(rnd.randint(5328731040,5521801341))
    mailAdresi = str(SahisIsim).lower() + str(SahisSoyisim).lower() + '@mail.com'
    Tr2Eng = str.maketrans("çğıöşü", "cgiosu")
    mailAdresiIng = mailAdresi.translate(Tr2Eng)
    mailAdresiIng = mailAdresiIng.replace(" ",'')
    personel_isim_tablosu.loc[i,"Eposta"] = str(mailAdresiIng)
    randStartDate = str(rnd.randint(1,28)) + "." + str(rnd.randint(1,12)) + "." + str(rnd.randint(2015,2024))
    personel_isim_tablosu.loc[i,"BaslangicTarihi"] = str(randStartDate)
    il_ilce = ilce_kod_sozluk[rnd.randint(0,995)]
    personel_isim_tablosu.loc[i,"DogumIl"] = str(il_ilce[0])
    personel_isim_tablosu.loc[i,"DogumIlce"] = str(il_ilce[3])
    listC = [1,2,3,4,5,6,7,8,9,10,11,12]
    personel_isim_tablosu.loc[i,"Pozisyon"] = str(rnd.choice(listC))
    personel_sube_firma = subeler_firmalar[rnd.randint(0,8560)]
    personel_isim_tablosu.loc[i,"Firma"] = str(personel_sube_firma[0])
    personel_isim_tablosu.loc[i,"Sube"] = str(personel_sube_firma[1])

personel_isim_tablosu.to_excel('personel_isim_guncel.xlsx', index=False)
    
