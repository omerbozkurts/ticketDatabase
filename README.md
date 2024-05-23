# Ticket Sale for Bus, Flight, Train and Ship
# Relational Database System
    

##	Sistemi kullanacak birçok farklı seyahat firması olacaktır. Bu firmaların her birine ait aşağıdaki bilgiler sistemde saklanabilmelidir:
•	Firma adı
•	Telefon numarası
•	Web sitesi adresi
•	Genel merkez adresi
•	Genel merkezin bulunduğu il
•	Genel merkezin bulunduğu ilçe
•	Kuruluş yılı
##	Firmalara ait farklı birçok adreste şubeler olabilmektedir. Her bir şubeye ait aşağıdaki bilgiler sistemde saklanabilmelidir:
•	Şube ismi
•	Adres
•	Telefon numarası
•	Bulunduğu il
•	Bulunduğu ilçe
Ayrıca her bir şubede farklı pozisyonlarda çalışan personeller olduğu için bu personellerin de ilgili şubede hangi pozisyonda görev aldıkları saklanabilmelidir.
##	Her firmanın kendisine ait birçok farklı araç türünde (otobüs, uçak vb.) aracı olabilecektir. Araçların ortak özelliklerine ait aşağıdaki bilgiler sistemde saklanabilmelidir:
•	Marka
•	Model
•	Motor hacmi
•	Motor gücü
•	Koltuk sayısı
•	Bagaj taşıma kapasitesi (kg olarak)
Ayrıca her firmanın kendisine ait araçları için de aşağıdaki bilgiler sistemde saklanabilmelidir
•	Araç benzersiz numarası (otobüslerde plaka, uçaklarda kanat numarası vb.)
•	Alış tarihi
•	Alış maliyeti
•	Kilometresi
•	Iskartaya çıkarıldığı tarih
##	Firmalarda çalışan birçok farklı pozisyonda (bilet kesen, muavin, şoför, vb.) personeller vardır. Bu personellere ait aşağıdaki bilgiler sistemde saklanabilmelidir:
•	T.C. kimlik no
•	Ad
•	Soyad
•	Cinsiyet
•	Medeni hal
•	Telefon
•	e-posta
•	Doğum tarihi
•	Doğum yeri
•	İşe başlama tarihi
•	İşten ayrılma tarihi
•	Görevi
##	Sistemi kullanacak yolcuların öncelikle sisteme kaydolmaları gerekmektedir. Yolculara ait aşağıdaki bilgiler sistemde saklanabilmelidir:
•	T.C. kimlik no
•	Ad
•	Soyad
•	Cinsiyet
•	Doğum tarihi
•	Yaş
•	Telefon
•	e-posta
•	Kullanıcı şifresi
•	Aktiflik durumu
##	Firmaların farklı sayılarda güzergâh tanımları olabilmektedir. Örneğin bir firmanın İstanbul-Ankara güzergahında otobüs seferi hiç yokken bir başkasının haftada sadece bir kez olabilir. Bir başka firmanın da her gün hem otobüs hem de tren seferi olabilir. Bu güzergâh tanımlamalarının her birisi için aşağıdaki bilgiler sistemde saklanabilmelidir:
•	Kalkış ve varış durakları
•	Varsa arada uğranan diğer durakların hangileri olduğu (uğranma sıralarıyla birlikte)
##	Firmalar istedikleri güzergahlar için istedikleri zamanlara ait sefer tanımları yapabilmelidir. Her bir sefer mutlaka bir güzergâh için yapılmaktadır. Her bir sefer için aşağıdaki bilgiler sistemde saklanabilmelidir:
•	Seferde hangi aracın kullanıldığı
•	Görev alan personel ya da personellerin kim oldukları
•	Seferin kalkış tarih ve saati
•	Seferin varış tarih ve saati
•	Kalkış ve varış duraklarında hangi peronların kullanılacağı
•	Uğranan tüm duraklara ait giriş-çıkış tarih ve saatleri
•	İlgili seferdeki aracın anlık olarak hangi enlem ve boylamda olduğu 
##	Kullanıcıların aldıkları her bir bilet bir sefer için olmaktadır. Her bilet için aşağıdaki bilgiler sistemde saklanabilmelidir:
•	Numarası
•	Ücreti
•	Kesildiği tarih
•	Koltuk numarası (uçaklarda bu alan bilet kesildiğinde belli değildir)
•	Checkin durumu (uçak biletleri içindir. Yapılmadı ve yapıldı diye iki durum olabilmektedir)
•	Checkin tarih ve saati (uçak biletleri için)
•	Binilecek ve inilecek peron bilgileri
•	Bileti kesen şube ve personel bilgisi

# Select Query

###Geçen ay (sistem tarihine göre otomatik alınacaktır) en çok yolcu taşıyan ilk üç firmanın hepsiyle bu ay içinde en az iki kez seyahat etmiş yolcuların il bazında erkek ve kadın sayıları
###Bu ay içinde PAMUKKALE firmasından hem Ankara-İstanbul hem de İzmir-İstanbul otobüs bileti alan yolcuların tcno, ad, soyad, tel bilgileri (dikkat : önemli olan güzergah başlangıç-bitiş noktaları değil biletin başlangıç-bitiş noktası)
