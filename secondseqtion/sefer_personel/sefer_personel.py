import pandas as pd

# Örnek tabloyu oluşturalım
data = {
    "PersonelId": [None] * 808,
    "SeferId": range(145, 145 + 808)
}
table = pd.DataFrame(data)

# Şoför ve muavin ID aralıkları
sofor_ids = list(range(17, 107))  # 17-106 (dahil)
muavin_ids = list(range(450, 540))  # 450-539 (dahil)

# Her 9 kişilik grup bir firmaya ait
sofor_groups = [sofor_ids[i:i + 9] for i in range(0, len(sofor_ids), 9)]
muavin_groups = [muavin_ids[i:i + 9] for i in range(0, len(muavin_ids), 9)]

# Firma sayısını kontrol et
num_firms = min(len(sofor_groups), len(muavin_groups))
rows_per_firma = 40  # Her firmanın 40 satırı var

# Tabloyu doldurmak için
for i in range(0, 404, rows_per_firma):
    firma_index = (i // rows_per_firma) % num_firms  # Grupları döngüsel kullan
    sofor_group = sofor_groups[firma_index]
    muavin_group = muavin_groups[firma_index]

    current_sofor_idx = 0
    current_muavin_idx = 0

    for j in range(rows_per_firma):
        if j % 2 == 0:  # Şoför satırı
            table.loc[i + j, "PersonelId"] = sofor_group[current_sofor_idx % 9]
            current_sofor_idx += 1
        else:  # Muavin satırı
            table.loc[i + j, "PersonelId"] = muavin_group[current_muavin_idx % 9]
            current_muavin_idx += 1

# Sonuçları kontrol etmek için tabloyu bir Excel dosyasına kaydedelim
table.to_excel("sefer_personel_duzenlenmis.xlsx", index=False)

print("İşlem tamamlandı! İlk 404 satır düzenlendi ve 'sefer_personel_duzenlenmis.xlsx' olarak kaydedildi.")
