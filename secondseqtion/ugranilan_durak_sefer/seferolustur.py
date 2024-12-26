import pandas as pd

ugranilan_sefer_tablo = pd.read_excel("ugranilan_durak_sefer.xlsx")

durakIdTablo = [99,98,96,86,66,51,29,19]

deger = 346
for i in range(0,1616):
    ugranilan_sefer_tablo.loc[i,"DurakSira"] = i%8 +2
    ugranilan_sefer_tablo.loc[i,"DurakId"]  = durakIdTablo[i%8]
    if i%8==0:
       deger += 1
    ugranilan_sefer_tablo.loc[i,"SeferDurak"] = deger 


ugranilan_sefer_tablo.to_excel('ugranilan_sefer_guncel2.xlsx',index=False)