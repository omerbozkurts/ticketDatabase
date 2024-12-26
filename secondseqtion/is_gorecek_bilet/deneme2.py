import pandas as pd
import random
from datetime import datetime, timedelta

# Excel dosyalarını yükleme
binis_inis_durak = pd.read_excel('binis_inis_durak.xlsx')
firma_sube_biletkesen = pd.read_excel('firma_sube_biletkesen.xlsx')
sefer_arac_firma = pd.read_excel('sefer_arac_firma.xlsx')

# Rastgele tarih oluşturma fonksiyonu
def random_date(start_date, end_date):
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    random_time = timedelta(minutes=random.randint(0, 1440))
    return start_date + timedelta(days=random_days) + random_time

# Veri oluşturma için parametreler
start_date = datetime(2023, 1, 1)
end_date = datetime(2024, 12, 31)

# 10,000 adet bilet verisi oluşturma
bilet_data = []
unique_checker = set()

for _ in range(20000):
    # Firma, Şube, Bilet Kesen rastgele seçimi
    firma_sube_row = firma_sube_biletkesen.sample(1).iloc[0]
    firma = firma_sube_row['Firma']
    sube = firma_sube_row['Sube']
    bilet_kesen = firma_sube_row['BiletKesen']

    # Sefer, Araç, Firma eşleşmesi
    sefer_row = sefer_arac_firma[sefer_arac_firma['Firma'] == firma].sample(1).iloc[0]
    sefer = sefer_row['SeferId']
    arac = sefer_row['Arac']

    # Biniş ve İniş durakları seçimi
    sefer_duraklar = binis_inis_durak[binis_inis_durak['SeferDurak'] == sefer]
    if len(sefer_duraklar) < 2:
        continue  # Eğer sefer için yeterli durak yoksa atla

    binis_durak = sefer_duraklar.sample(1).iloc[0]
    inis_durak = sefer_duraklar[sefer_duraklar['DurakSira'] > binis_durak['DurakSira']]

    if inis_durak.empty:
        continue  # İniş durağı bulunamadıysa atla

    inis_durak = inis_durak.sample(1).iloc[0]

    # Rastgele diğer veriler
    bilet_id = f"B{random.randint(100000, 999999)}"
    ucret = random.randint(700, 1400)
    kesilme_tarih = random_date(start_date, end_date)
    koltuk_no = random.randint(1, 50)
    check_in_durum = random.choice([True, False])
    check_in_date = random_date(kesilme_tarih, kesilme_tarih + timedelta(hours=24)) if check_in_durum else None

    yolcu = random.randint(1, 1200)
    guzergah = 13

    # Unique kontrolü
    unique_key = (koltuk_no, firma, sefer, arac)
    if unique_key in unique_checker:
        continue

    unique_checker.add(unique_key)

    bilet_data.append({
        'BiletId': bilet_id,
        'Ucret': ucret,
        'KesilmeTarih': kesilme_tarih,
        'KoltukNo': koltuk_no,
        'CheckInDurum': check_in_durum,
        'CheckInDate': check_in_date,
        'Firma': firma,
        'Sube': sube,
        'BiletKesen': bilet_kesen,
        'Yolcu': yolcu,
        'Guzergah': guzergah,
        'Sefer': sefer,
        'BinisDurak': binis_durak['UgranilanDurakId'],
        'InisDurak': inis_durak['UgranilanDurakId'],
        'Arac': arac
    })

# Veriyi DataFrame'e çevirme ve kaydetme
bilet_df = pd.DataFrame(bilet_data)
bilet_df.to_excel('bilet_verisi2.xlsx', index=False)

print("Bilet verisi başarıyla oluşturuldu ve 'bilet_verisi.xlsx' dosyasına kaydedildi.")
