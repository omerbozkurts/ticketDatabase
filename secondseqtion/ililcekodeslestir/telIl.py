import pandas as pd

# İlk Excel tablosunu yükle
ilk_tablo_path = "ilce-listesi.xlsx"  # İlk Excel dosyasının yolu
ilk_tablo = pd.read_excel(ilk_tablo_path)
# İkinci Excel tablosunu yükle
ikinci_tablo_path = "firmatelNo_guncel.xlsx"  # İkinci Excel dosyasının yolu
ikinci_tablo = pd.read_excel(ikinci_tablo_path)



# İlk tablodaki verileri bir sözlük yapısına dönüştür
ilce_kod_sozluk = {}
for _, row in ilk_tablo.iterrows():
    il = row["IL_ADI"]
    il_kod = row["IL_KODU"]
    ilce = row["AD"]
    ilce_kod = row["ILCE_KODU"]
    if il not in ilce_kod_sozluk:
        ilce_kod_sozluk[il] = {"il_kod": il_kod, "ilceler": {}}
    ilce_kod_sozluk[il]["ilceler"][ilce] = ilce_kod



# Kodları doldurmak için ikinci tabloyu güncelle
for index, row in ikinci_tablo.iterrows():
    k_il = row["Firma_Adresi"]

    
    # k_il ve k_ilce için kodları bul
    if k_il in ilce_kod_sozluk:
        ikinci_tablo.loc[index, "IlKodu"] = ilce_kod_sozluk[k_il]["il_kod"]
        ilk_key = next(iter(ilce_kod_sozluk[k_il]['ilceler']))
        ilk_value = ilce_kod_sozluk[k_il]['ilceler'][ilk_key]
        ikinci_tablo.loc[index, "IlceKodu"] = ilk_value

    # v_il ve v_ilce için kodları bul
# Güncellenmiş ikinci tabloyu yeni bir dosyaya kaydet
ikinci_tablo.to_excel("firmatelNo_guncel2.xlsx", index=False)

print("Kodlama işlemi tamamlandı. Güncellenmiş dosya: ikinci_tablo_guncel.xlsx")