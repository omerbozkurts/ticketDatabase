import pandas as pd
import random as rnd

# Dosyaları yükleyin
subeler_tablosu = pd.read_excel('sube.xlsx')
ilceler_tablosu = pd.read_excel('ilce-listesi.xlsx')

# Firma sözlüğü
firma = {
    40: 'Vogo', 
    41: 'Akpolat',
    42: 'Balıkesir Uludağ',
    43: 'Doğuş Diyar Birlik',
    44: 'Izmir Turizm',
    45: 'Tozcan',
    46: 'Niksarkale',
    47: 'Hatay Nur',
    48: 'Nokta',
    49: 'İyigün Çarşamba'
}

# Yeni verileri doldurma
for index, row in subeler_tablosu.iterrows():
    subeIlKodu = row['SubeIl']
    subeIlceKodu = row['SubeIlce']
    subeFirmaKodu = row['SubeFirma']

    # İl ve ilçe adlarını bulma
    ilce_row = ilceler_tablosu[(ilceler_tablosu['IL_KODU'] == subeIlKodu) & (ilceler_tablosu['ILCE_KODU'] == subeIlceKodu)]
    if not ilce_row.empty:
        subeIlAdi = ilce_row['IL_ADI'].values[0]
        subeIlceAdi = ilce_row['AD'].values[0]
    else:
        subeIlAdi = "Bilinmiyor"
        subeIlceAdi = "Bilinmiyor"

    # Firma ismini bulma
    firma_adi = firma.get(subeFirmaKodu, "Bilinmiyor")
    
    # Verileri doldurma
    subeler_tablosu.loc[index, "SubeAd"] = f"{firma_adi} {subeIlAdi} {subeIlceAdi} Şubesi"
    subeler_tablosu.loc[index, "SubeAdres"] = f"{subeIlAdi.capitalize()} {subeIlceAdi.capitalize()}"
    subeler_tablosu.loc[index, "TelNo"] = str(rnd.randint(3124534156, 4801801341))
    subeler_tablosu.loc[index, "TelNo2"] = str(rnd.randint(5328731040, 5521801341))
    subeler_tablosu.loc[index, "TelNo3"] = str(rnd.randint(5312001341, 5528001341))

# Doldurulmuş tabloyu kaydetme
subeler_tablosu.to_excel('doldurulmus_subeler.xlsx', index=False)
