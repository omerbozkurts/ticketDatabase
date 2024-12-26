import requests
from bs4 import BeautifulSoup
import pandas as pd

# Hedef URL
url = "https://www.enuygun.com/otobus-bileti/otobus-firmalari/"

# HTTP isteği gönder ve sayfanın içeriğini al
response = requests.get(url)
response.raise_for_status()  # Hata durumunda exception fırlatır

# BeautifulSoup ile HTML içeriğini parse et
soup = BeautifulSoup(response.text, 'html.parser')

# Firmalar için liste
companies = []

# Firma bilgilerini içeren div'leri seç
company_elements = soup.select(".company-list-item")

for element in company_elements:
    # Firma adı
    name = element.select_one(".company-name").text.strip()
    
    # Web adresi
    web_address = element.get('href', '')

    # Firma detayları
    details = element.select_one(".company-info div span").text if element.select_one(".company-info div span") else ""

    # Kuruluş tarihi ve firma merkezi ayırma
    foundation_year = ""
    headquarters = ""
    if "Kuruluş Tarihi:" in details:
        parts = details.split(" - ")
        foundation_year = parts[0].replace("Kuruluş Tarihi: ", "").strip()
        if len(parts) > 1:
            headquarters = parts[1].replace("Firma Merkezi: ", "").strip()

    # Telefon bilgileri (örnek olarak boş bırakılmıştır)
    tel1, tel2, tel3 = "", "", ""

    # Firmayı listeye ekle
    companies.append({
        "Firma Adı": name,
        "Web Adresi": web_address,
        "Firma Adresi": headquarters,
        "Kuruluş Tarihi": foundation_year,
        "Tel1": tel1,
        "Tel2": tel2,
        "Tel3": tel3,
    })

# Verileri pandas DataFrame'e dönüştür
df = pd.DataFrame(companies)

# Excel dosyasına kaydet
output_file = "otobus_firmalari.xlsx"
df.to_excel(output_file, index=False)

print(f"Veriler '{output_file}' dosyasına kaydedildi.")
