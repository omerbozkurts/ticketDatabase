# Function to map city names to their plate codes (Türkiye's plaka kodları)
city_to_plate = {
    "Adana": 1, "Adıyaman": 2, "Afyon": 3, "Ağrı": 4, "Amasya": 5, "Ankara": 6,
    "Antalya": 7, "Artvin": 8, "Aydın": 9, "Balıkesir": 10, "Bilecik": 11, "Bingöl": 12,
    "Bitlis": 13, "Bolu": 14, "Burdur": 15, "Bursa": 16, "Çanakkale": 17, "Çankırı": 18,
    "Çorum": 19, "Denizli": 20, "Diyarbakır": 21, "Edirne": 22, "Elazığ": 23, "Erzincan": 24,
    "Erzurum": 25, "Eskişehir": 26, "Gaziantep": 27, "Giresun": 28, "Gümüşhane": 29, "Hakkari": 30,
    "Hatay": 31, "Isparta": 32, "Mersin": 33, "İstanbul": 34, "İzmir": 35, "Kars": 36, "Kastamonu": 37,
    "Kayseri": 38, "Kırklareli": 39, "Kırşehir": 40, "Kocaeli": 41, "Konya": 42, "Kütahya": 43,
    "Malatya": 44, "Manisa": 45, "Kahramanmaraş": 46, "Mardin": 47, "Muğla": 48, "Muş": 49,
    "Nevşehir": 50, "Niğde": 51, "Ordu": 52, "Rize": 53, "Sakarya": 54, "Samsun": 55,
    "Siirt": 56, "Sinop": 57, "Sivas": 58, "Tekirdağ": 59, "Tokat": 60, "Trabzon": 61,
    "Tunceli": 62, "Şanlıurfa": 63, "Uşak": 64, "Van": 65, "Yozgat": 66, "Zonguldak": 67,
    "Aksaray": 68, "Bayburt": 69, "Karaman": 70, "Kırıkkale": 71, "Batman": 72, "Şırnak": 73,
    "Bartın": 74, "Ardahan": 75, "Iğdır": 76, "Yalova": 77, "Karabük": 78, "Kilis": 79,
    "Osmaniye": 80, "Düzce": 81
}

# Helper function to fetch plate code based on city name
def get_plate_code(city):
    return city_to_plate.get(city, None)

# Update missing address and il code information
updated_data = sheet_data.copy()

for index, row in updated_data.iterrows():
    if pd.isna(row['Firma Adresi']):
        # Research the address based on the company name (mock example for now)
        if "Adıyaman" in row['Firma Adı']:
            updated_data.at[index, 'Firma Adresi'] = "Adıyaman"
        elif "Ağrı" in row['Firma Adı']:
            updated_data.at[index, 'Firma Adresi'] = "Ağrı"
        elif "Anamur" in row['Firma Adı']:
            updated_data.at[index, 'Firma Adresi'] = "Mersin"
        # Add more rules or integrate a web search API if required
    
    # Fill il code based on address
    if pd.isna(row['IlKodu']) and not pd.isna(updated_data.at[index, 'Firma Adresi']):
        city = updated_data.at[index, 'Firma Adresi']
        updated_data.at[index, 'IlKodu'] = get_plate_code(city)

# Display the changes
updated_data.head(20)
