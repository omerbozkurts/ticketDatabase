import pandas as pd

# Excel dosyasını oku
df = pd.read_excel("ilceler_arasi_mesafe.xlsx")

table_name = "ILCE_MESAFE"
columns = "(k_il,k_ilce,v_il,v_ilce,toplam_uzunluk,k_ilKodu,k_ilceKodu,v_ilkodu,v_ilcekodu)"
batch_size = 995

with open("ilceler_arasi_mesafe_insert.sql", "w", encoding="utf-8") as f:
    for i in range(0, len(df), batch_size):
        batch = df[i:i+batch_size]
        values = ",\n".join([
            "(" + ", ".join([f"'{x}'" if pd.notna(x) else "NULL" for x in row]) + ")"
            for row in batch.to_numpy()
        ])
        insert_statement = f"INSERT INTO {table_name} {columns} VALUES\n{values};\n"
        f.write(insert_statement)
print("SQL script created successfully!")
