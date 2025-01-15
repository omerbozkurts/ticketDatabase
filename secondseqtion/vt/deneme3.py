import pandas as pd

# Excel dosyasını oku
df = pd.read_excel("ilceler_arasi_mesafe.xlsx")

table_name = "ILCE_MESAFE"
columns = "(k_il,k_ilce,v_il,v_ilce,toplam_uzunluk,k_ilKodu,k_ilceKodu,v_ilkodu,v_ilcekodu)"
batch_size = 995

# Integer kolona özel işlemi yapacak fonksiyon
def format_value(x, column_name):
    if pd.isna(x):  # NaN değeri varsa NULL yaz
        return "NULL"
    elif column_name in ['k_ilKodu', 'k_ilceKodu', 'v_ilkodu', 'v_ilcekodu']:  # Integer kolonlar
        return str(int(x))  # Tam sayı olarak formatla
    else:  # Diğer kolonlar için string format
        return f"'{x}'"

with open("ilceler_arasi_mesafe_insert.sql", "w", encoding="utf-8") as f:
    for i in range(0, len(df), batch_size):
        batch = df[i:i+batch_size]
        values = ",\n".join([
            "(" + ", ".join([format_value(x, col) for x, col in zip(row, df.columns)]) + ")"
            for row in batch.to_numpy()
        ])
        insert_statement = f"INSERT INTO {table_name} {columns} VALUES\n{values};\n"
        f.write(insert_statement)

print("SQL script created successfully!")
