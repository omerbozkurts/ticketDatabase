import pandas as pd

# Excel dosyasını oku
df = pd.read_excel("bilet_verisi2.xlsx")

table_name = "BILET"
columns = "(Ucret, KesilmeTarih, KoltukNo, Firma, Sube, BiletKesen, Yolcu, Guzergah, Sefer, BinisDurak, InisDurak, Arac)"
batch_size = 999

with open("InsertStatements.sql", "w", encoding="utf-8") as f:
    for i in range(0, len(df), batch_size):
        batch = df[i:i+batch_size]
        values = ",\n".join([
            "(" + ", ".join([f"'{x}'" if pd.notna(x) else "NULL" for x in row]) + ")"
            for row in batch.to_numpy()
        ])
        insert_statement = f"INSERT INTO {table_name} {columns} VALUES\n{values};\n"
        f.write(insert_statement)
print("SQL script created successfully!")
