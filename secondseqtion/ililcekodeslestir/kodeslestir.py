import pandas as pd

# İlk Excel tablosunu yükle
ilk_tablo_path = "ilce-listesi.xlsx"  # İlk Excel dosyasının yolu
ilk_tablo = pd.read_excel(ilk_tablo_path)
# İkinci Excel tablosunu yükle
ikinci_tablo_path = "ilcemesafe.xlsx"  # İkinci Excel dosyasının yolu
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
    k_il = row["k_il"]
    k_ilce = row["k_ilce"]
    v_il = row["v_il"]
    v_ilce = row["v_ilce"]
    # k_il ve k_ilce için kodları bul
    if k_il in ilce_kod_sozluk:
        ikinci_tablo.loc[index, "k_ilKodu"] = ilce_kod_sozluk[k_il]["il_kod"]
        if k_ilce in ilce_kod_sozluk[k_il]["ilceler"]:
            ikinci_tablo.loc[index, "k_ilceKodu"] = ilce_kod_sozluk[k_il]["ilceler"][k_ilce]

    # v_il ve v_ilce için kodları bul
    if v_il in ilce_kod_sozluk:
        ikinci_tablo.loc[index, "v_ilkodu"] = ilce_kod_sozluk[v_il]["il_kod"]
        if v_ilce in ilce_kod_sozluk[v_il]["ilceler"]:
            ikinci_tablo.loc[index, "v_ilcekodu"] = ilce_kod_sozluk[v_il]["ilceler"][v_ilce]

# Güncellenmiş ikinci tabloyu yeni bir dosyaya kaydet
ikinci_tablo.to_excel("ikinci_tablo_guncel.xlsx", index=False)

print("Kodlama işlemi tamamlandı. Güncellenmiş dosya: ikinci_tablo_guncel.xlsx")