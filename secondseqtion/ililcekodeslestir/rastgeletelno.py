import random as rnd
import pandas as pd

tablo = pd.read_excel('otobus_firmalari.xlsx')


for index, row in tablo.iterrows():
    tablo.loc[index,'Tel1'] = '0'+str(rnd.randint(2165131245,4867861242))
    tablo.loc[index,'Tel2'] = '0'+str(rnd.randint(5305104312,5524184624))


tablo.to_excel('firmatelNo.xlsx',index=False)