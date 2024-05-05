const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const app = express();

// JSON veri boyutu sınırını artırma
app.use(express.json({ limit: '10mb' }));

// URL kodlanmış veri boyutu sınırını artırma
app.use(express.urlencoded({ extended: true, limit: '10mb' }));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const port = 3000;

const db = mysql.createConnection({
  host: '127.0.0.1',
  port: '3306',
  user: 'root',
  password: 'Cecomysql004',
  database: 'rentalkontrol'
});

db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log('MySQL bağlantısı başarılı!');
});

let adres_id = 0;
let sayac = 0;
let musteri_id = "KU" + sayac;

//___________Birleştirilen değişkenler___________
let kiralama_id = 100;
let odeme_id = 0;
let sayac2 = 0;
let sayac3 = 0;

let araba_sahibi_id = "AS" + sayac2;
let araba_id = "AB" + sayac3;

//_______________________________________________

async function updateMaxIds() {
  const query1 = 'SELECT MAX(adres_id) AS maxAdresId FROM adres';
  const query2 = 'SELECT MAX(musteri_id) AS maxMusteriId FROM musteribilgileri';

  //________Birleştirilmiş ID SQL Komutları________
  const query3 = 'SELECT MAX(araba_sahibi_id) AS maxaraba_sahibi_id FROM araba_sahibi_modu';
  const query4 = 'SELECT MAX(araba_id) AS maxaraba_id FROM araba_bilgileri';
  const query5 = 'SELECT MAX(odeme_id) AS maxodeme_id FROM odemebilgileri';
  const query6 = 'SELECT MAX(kiralama_id) AS maxkiralama_id FROM kiralamabilgileri';
  //________________________________________________

  await db.query(query1, (err, result) => {
    if (err) throw err;
    adres_id = result[0].maxAdresId || 0;
  });

  await db.query(query2, (err, result) => {
    if (err) throw err;
    let maxId = result[0].maxMusteriId || "KU0";
    sayac = parseInt(maxId.slice(2)); // "KU1" stringinin sonundaki sayıyı alır
  });

  //__________Birleştirilmiş ID Kontrolleri_____________
  await db.query(query3, (err, result) => {
    if (err) throw err;
    let maxId = result[0].maxaraba_sahibi_id || "AS0";
    sayac2 = parseInt(maxId.slice(2)); // "AS0" stringinin sonundaki sayıyı alır
  });


  await db.query(query4, (err, result) => {
    if (err) throw err;
    let maxId = result[0].maxaraba_id || "AB0";
    sayac3 = parseInt(maxId.slice(2)); // "AB1" stringinin sonundaki sayıyı alır
  });

  await db.query(query5, (err, result) => {
    if (err) throw err;
    odeme_id = result[0].maxodeme_id || 0;
  });
  await db.query(query6, (err, result) => {
    if (err) throw err;
    kiralama_id = result[0].maxkiralama_id || 100;
  });
  //_____________________________________________________
}

updateMaxIds().then(() => {
  app.listen(port, () => {
    console.log(`Sunucu ${port} portunda çalışıyor...`);
  });
}).catch((err) => {
  console.log(err);
});

//________________________________________VERİ EKLEME__________________________________________________

app.post('/kisiselbilgiler', (req, res) => {
  const { ad, soyad, tc_kimlik, cinsiyet, dogum_tarihi, ehliyet_serino, telefon_no, email, sifre } = req.body;
  const sql = 'INSERT INTO musteribilgileri (musteri_id, ad, soyad, tc_kimlik, cinsiyet, dogum_tarihi, ehliyet_serino, telefon_no, email, adres_id, sifre) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
  sayac++;
  musteri_id = "KU" + sayac;
  db.query(sql, [musteri_id, ad, soyad, tc_kimlik, cinsiyet, dogum_tarihi, ehliyet_serino, telefon_no, email, adres_id, sifre], (err, result) => {
    if (err) {
      throw err;
    }
    res.json(result);
  });
});


app.post('/adresbilgileri', (req, res) => {
  // body-parser ile gelen verilere erişin
  const { il, ilce, mahalle, cadde, sokak, apartmanno, daireno } = req.body;
  const sql = 'INSERT INTO adres (adres_id, il, ilce, mahalle, cadde, sokak, apartmanno, daireno) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
  adres_id++;
  // Sorguyu çalıştırma
  db.query(sql, [adres_id, il, ilce, mahalle, cadde, sokak, apartmanno, daireno], (err, result) => {
    if (err) {
      throw err;
    }
    res.json(result);
  });
});

//Birleştirilmiş API adresleri

app.post('/arababilgileri', (req, res) => {
  const { marka, model, yil, vites, km, motor_gucu, yakit, hasar_kaydi, fiyat, } = req.body;
  let { image } = req.body; // Base64 formatında fotoğraf
  const sql = 'INSERT INTO araba_bilgileri (araba_id, marka, model, yil, vites, km, motor_gucu, yakit, hasar_kaydi, fiyat, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
  sayac3++;
  araba_id = "AB" + sayac3;
  db.query(sql, [araba_id, marka, model, yil, vites, km, motor_gucu, yakit, hasar_kaydi, fiyat, image], (err, result) => {
    if (err) {
      throw err;
    }
    res.json({ result });
  });
});

app.post('/arabasahibibilgileri', (req, res) => {
  const { iban, kasko_no, ruhsatseri_no, tc_kimlik } = req.body;

  // Müşteri ID'sini almak için SQL sorgusu
  const selectSql = 'SELECT musteri_id FROM musteribilgileri WHERE tc_kimlik = ?';
  db.query(selectSql, [tc_kimlik], (selectErr, selectResult) => {
    if (selectErr) {
      throw selectErr;
    }

    // Müşteri bulunamadıysa hata dön
    if (selectResult.length === 0) {
      res.status(404).json({ error: 'Müşteri bulunamadı' });
      return;
    }
    const musteri_id = selectResult[0].musteri_id;
    // Araba sahibi kaydını eklemek için SQL sorgusu
    const insertSql = 'INSERT INTO araba_sahibi_modu (araba_sahibi_id, musteri_id, araba_id, iban, kasko_no, ruhsatseri_no) VALUES (?, ?, ?, ?, ?, ?)';
    sayac2++;
    araba_sahibi_id = "AS" + sayac2;
    db.query(insertSql, [araba_sahibi_id, musteri_id, araba_id, iban, kasko_no, ruhsatseri_no], (err, result) => {
      if (err) {
        throw err;
      }
      res.json(result);
    });
  });
});


app.post('/odemebilgileri', (req, res) => {
  const { kart_no, son_kullanma_tarihi, cvv, kartIsim } = req.body;
  const sql = 'INSERT INTO odemebilgileri (odeme_id, kart_no, son_kullanma_tarihi, cvv, kartIsim) VALUES (?, ?, ?, ?, ?)';
  odeme_id++;
  db.query(sql, [odeme_id, kart_no, son_kullanma_tarihi, cvv, kartIsim], (err, result) => {
    if (err) {
      throw err;
    }
    const { tc_kimlik } = req.body;
    const updateSql = 'UPDATE musteribilgileri SET odeme_id = ? WHERE tc_kimlik = ?';
    db.query(updateSql, [odeme_id, tc_kimlik], (updateErr, updateResult) => {
      if (updateErr) {
        throw updateErr;
      }
      res.json(updateResult);
    });
  });
})

app.post('/kiralamabilgileri', (req, res) => {
  let musteri_id, araba_id;
  const { baslangic_tarihi, bitis_tarihi, tc_kimlik, ruhsatseri_no } = req.body;

  const musteriBul = 'SELECT musteri_id FROM musteribilgileri WHERE tc_kimlik = ?';
  const arabaBul = 'SELECT * FROM araba_sahibi_modu JOIN araba_bilgileri ON araba_sahibi_modu.araba_id = araba_bilgileri.araba_id WHERE ruhsatseri_no = ?';
  db.query(musteriBul, [tc_kimlik], (musterierr, musteriresult) => {
    if (musterierr) {
      throw musteriresult;
    }

    if (musteriresult.length > 0) {
      musteri_id = musteriresult[0].musteri_id;
    }

    db.query(arabaBul, [ruhsatseri_no], (arabaerr, arabaresult) => {
      if (arabaerr) {
        throw arabaerr;
      }

      if (arabaresult.length > 0) {
        araba_id = arabaresult[0].araba_id;
      }

      const sql = 'INSERT INTO kiralamabilgileri (kiralama_id, yeni_musteri_id, yeni_araba_id, baslangic_tarihi, bitis_tarihi ) VALUES (?, ?, ?, ?, ?)';
      kiralama_id++;
      db.query(sql, [kiralama_id, musteri_id, araba_id, baslangic_tarihi, bitis_tarihi], (err, result) => {
        if (err) {
          throw err;
        }
        res.json(result);
      });
    });
  });
});


//________________________________________VERİ KONTROLÜ__________________________________________________

app.post('/tckontrol', (req, res) => {
  const { tc_kimlik } = req.body;
  const checkSql = 'SELECT tc_kimlik FROM musteribilgileri WHERE tc_kimlik = ?';

  db.query(checkSql, [tc_kimlik], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0 && result[0].tc_kimlik === tc_kimlik) {
      res.json({ message: 'Girdiğiniz T.C. kimlik numarası daha önce kullanılmış.' });

    } else {
      res.json({ message: '' });
    }
  });
});

app.post('/ehliyetkontrol', (req, res) => {
  const { ehliyet_serino } = req.body;
  const checkSql = 'SELECT ehliyet_serino FROM musteribilgileri WHERE ehliyet_serino = ?';

  db.query(checkSql, [ehliyet_serino], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0 && result[0].ehliyet_serino === ehliyet_serino) {
      res.json({ message: 'Girdiğiniz seri numarası, kimlik bilgilerinizdeki ile uyuşmuyor.' });
    } else {
      res.json({ message: '' });
    }
  });
});

app.post('/telkontrol', (req, res) => {
  const { telefon_no } = req.body;
  const checkSql = 'SELECT telefon_no FROM musteribilgileri WHERE telefon_no = ?';
  db.query(checkSql, [telefon_no], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0 && result[0].telefon_no === telefon_no) {
      res.json({ message: 'Girdiğiniz telefon numarası zaten kullanılmış.' });
    } else {
      res.json({ message: '' });
    }
  });
});

app.post('/mailkontrol', (req, res) => {
  const { email } = req.body;
  const checkSql = 'SELECT email FROM musteribilgileri WHERE email = ?';

  db.query(checkSql, [email], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0 && result[0].email === email) {
      res.json({ message: 'Girdiğiniz e-posta adresi zaten kullanılmış.' });
    } else {
      res.json({ message: '' });
    }
  });
});

//Birleştirilmiş API Adresleri

app.post('/ruhsatnokontrol', (req, res) => {
  const { ruhsatseri_no } = req.body;
  const checkSql = 'SELECT * from araba_sahibi_modu WHERE ruhsatseri_no = ?';

  db.query(checkSql, [ruhsatseri_no], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      res.json({ message: 'Girdiğiniz ruhsat seri numarası daha önce kullanılmış.' });
    }
    else {
      res.json({ message: '' });
    }
  });
});

app.post('/kaskokontrol', (req, res) => {
  const { kasko_no } = req.body;
  const checkSql = 'SELECT * from araba_sahibi_modu WHERE kasko_no = ?';

  db.query(checkSql, [kasko_no], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      res.json({ message: 'Girdiğiniz kasko numarası daha önce kullanılmış.' });
    }
    else {
      res.json({ message: '' });
    }
  });
});

app.post('/arabaverigenel', (req, res) => {
  const { tc_kimlik } = req.body;
  const checkSql = 'SELECT * FROM araba_sahibi_modu JOIN musteribilgileri ON musteribilgileri.musteri_id = araba_sahibi_modu.musteri_id WHERE tc_kimlik = ?';

  db.query(checkSql, [tc_kimlik], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      res.json({ message: '' });
    } else {
      res.json({ message: 'Kayıtlı bir arabanız bulunmamaktadır. Araba sahibi modu için kayıt yaptırmak ister misiniz?' });
    }
  });
});

//________________________________________VERİ DEĞİŞTİRME__________________________________________________

app.post('/sifredegistir', (req, res) => {
  const { sifre, tc_kimlik } = req.body;
  const sql = 'UPDATE musteribilgileri SET sifre = ? WHERE tc_kimlik = ?';
  db.query(sql, [sifre, tc_kimlik], (err, result) => {
    if (err) { throw err; }
    else {
      if (result.length > 0) {
        res.json(result);
      }
    }
  });
});

app.post('/adresguncelle', (req, res) => {
  const { il, ilce, mahalle, cadde, sokak, apartmanno, daireno, tc_kimlik } = req.body;
  const sql = 'UPDATE adres JOIN musteribilgileri ON musteribilgileri.adres_id = adres.adres_id SET il = ?, ilce = ?, mahalle = ?, cadde = ?, sokak = ?, apartmanno = ?, daireno = ? WHERE musteribilgileri.tc_kimlik = ?';
  db.query(sql, [il, ilce, mahalle, cadde, sokak, apartmanno, daireno, tc_kimlik], (err, result) => {
    if (err) { throw err; }
    else {
      if (result.length > 0) {
        res.json(result);
      }
    }
  });
});

app.post('/telnodegistir', (req, res) => {
  const { telefon_no, tc_kimlik } = req.body;
  const sql = 'UPDATE musteribilgileri SET telefon_no = ? WHERE tc_kimlik = ?';
  db.query(sql, [telefon_no, tc_kimlik], (err, result) => {
    if (err) { throw err; }
    else {
      if (result.length > 0) {
        res.json(result);
      }
    }
  });
});

app.post('/maildegistir', (req, res) => {
  const { email, tc_kimlik } = req.body;
  const sql = 'UPDATE musteribilgileri SET email = ? WHERE tc_kimlik = ?';
  db.query(sql, [email, tc_kimlik], (err, result) => {
    if (err) { throw err; }
    else {
      if (result.length > 0) {
        res.json(result);
      }
    }
  });
});

app.post('/fiyatdegistir', (req, res) => {
  const { fiyat, ruhsatseri_no } = req.body;
  const sql = ' UPDATE araba_bilgileri JOIN araba_sahibi_modu ON araba_bilgileri.araba_id = araba_sahibi_modu.araba_id SET fiyat = ? WHERE araba_sahibi_modu.ruhsatseri_no = ?';
  db.query(sql, [fiyat, ruhsatseri_no], (err, result) => {
    if (err) { throw err; }
    else {
      if (result.length > 0) {
        res.json(result);
      }
    }
  });
});

//________________________________________VERİ ÇEKME_______________________________________________________

app.post('/girisyap', (req, res) => {
  const { email, sifre } = req.body;
  const mailsifre = 'SELECT sifre FROM musteribilgileri WHERE email = ?';
  db.query(mailsifre, [email], (kontrolerr, kontrolresult) => {
    if (kontrolerr) {
      throw kontrolerr;
    }
    if (kontrolresult.length > 0) {
      const sifrekontrol = kontrolresult[0].sifre;
      if (sifre == sifrekontrol) {
        res.json({ message: '' });
      }
      else {
        res.json({ message: 'Hatalı e-mail veya şifre girişi!' });
      }
    }
    else {
      res.json({ message: 'Hatalı e-mail veya şifre girişi!' });
    }
  });
});

app.post('/kisiselbilgigirisi', (req, res) => {
  const { email } = req.body;
  const kisiselbilgiler = 'SELECT * FROM musteribilgileri JOIN adres ON adres.adres_id = musteribilgileri.adres_id WHERE email = ?';

  db.query(kisiselbilgiler, [email,], (kisierr, kisiresult) => {
    if (kisierr) {
      throw kisierr;
    }
    if (kisiresult.length > 0) {
      res.json({
        adbilgi: kisiresult[0].ad,
        soyadbilgi: kisiresult[0].soyad,
        tcbilgi: kisiresult[0].tc_kimlik,
        cinsiyetbilgi: kisiresult[0].cinsiyet,
        dtarihbilgi: kisiresult[0].dogum_tarihi,
        ehliyetbilgi: kisiresult[0].ehliyet_serino,
        telefonbilgi: kisiresult[0].telefon_no,
        mailbilgi: kisiresult[0].email,
        sifrebilgi: kisiresult[0].sifre,

        ilbilgi: kisiresult[0].il,
        ilcebilgi: kisiresult[0].ilce,
        mahallebilgi: kisiresult[0].mahalle,
        caddebilgi: kisiresult[0].cadde,
        sokakbilgi: kisiresult[0].sokak,
        apartmannobilgi: kisiresult[0].apartmanno,
        dairenobilgi: kisiresult[0].daireno
      });
    }
  });
});

app.post('/odemebilgigirisi', (req, res) => {
  const { email } = req.body;
  const odemebilgileri = 'SELECT * FROM musteribilgileri JOIN odemebilgileri ON odemebilgileri.odeme_id = musteribilgileri.odeme_id WHERE email = ?';
  db.query(odemebilgileri, [email], (odemeerr, odemeresult) => {
    if (odemeerr) {
      throw odemeerr;
    }
    if (odemeresult.length > 0) {
      res.json({
        kartbilgi: odemeresult[0].kart_no,
        starihbilgi: odemeresult[0].son_kullanma_tarihi,
        cvvbilgi: odemeresult[0].cvv,
        kartisimbilgi: odemeresult[0].kartIsim
      });
    }
    else {
      res.json({
        kartbilgi: "",
        starihbilgi: "",
        cvvbilgi: "",
        kartisimbilgi: ""
      });
    }
  });
});

app.post('/arababilgigirisi', (req, res) => {
  const { email } = req.body;
  const arababilgileri = 'SELECT * FROM araba_sahibi_modu JOIN musteribilgileri ON musteribilgileri.musteri_id = araba_sahibi_modu.musteri_id JOIN araba_bilgileri ON araba_sahibi_modu.araba_id = araba_bilgileri.araba_id WHERE email = ?';
  db.query(arababilgileri, [email], (arabaerr, arabaresult) => {
    if (arabaerr) {
      throw arabaerr;
    }
    if (arabaresult.length > 0) {
      res.json({
        markabilgi: arabaresult[0].marka,
        modelbilgi: arabaresult[0].model,
        yilbilgi: arabaresult[0].yil,
        vitesbilgi: arabaresult[0].vites,
        kmbilgi: arabaresult[0].km,
        motor_gucubilgi: arabaresult[0].motor_gucu,
        yakitbilgi: arabaresult[0].yakit,
        hasar_kaydibilgi: arabaresult[0].hasar_kaydi,
        fiyatbilgi: arabaresult[0].fiyat,
        resimbilgi: arabaresult[0].image,

        ibanbilgi: arabaresult[0].iban,
        kaskonobilgi: arabaresult[0].kasko_no,
        ruhsatseribilgi: arabaresult[0].ruhsatseri_no
      });
    }
    else {
      res.json({
        markabilgi: '',
        modelbilgi: '',
        yilbilgi: '',
        vitesbilgi: '',
        kmbilgi: '',
        motor_gucubilgi: '',
        yakitbilgi: '',
        hasar_kaydibilgi: '',
        fiyatbilgi: '',
        resimbilgi: '',

        ibanbilgi: '',
        kaskonobilgi: '',
        ruhsatseribilgi: ''
      });
    }
  });
});




app.post('/kullanicibilgicek', (req, res) => {
  const { tc_kimlik } = req.body;
  const veriCek = 'SELECT * FROM musteribilgileri WHERE tc_kimlik = ?';
  db.query(veriCek, [tc_kimlik], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      res.json({
        adbilgi: result[0].ad,
        soyadbilgi: result[0].soyad,
        tcbilgi: result[0].tc_kimlik,
        cinsiyetbilgi: result[0].cinsiyet,
        dtarihbilgi: result[0].dogum_tarihi,
        telefonbilgi: result[0].telefon_no,
        mailbilgi: result[0].email
      });
    }
  });
});

app.post('/adresbilgicek', (req, res) => {
  const { tc_kimlik } = req.body;
  const veriCek = 'SELECT * FROM adres JOIN musteribilgileri ON musteribilgileri.adres_id = adres.adres_id WHERE tc_kimlik = ?';
  db.query(veriCek, [tc_kimlik], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      res.json({
        ilbilgi: result[0].il,
        ilcebilgi: result[0].ilce,
        mahallebilgi: result[0].mahalle,
        caddebilgi: result[0].cadde,
        sokakbilgi: result[0].sokak,
        apartmannobilgi: result[0].apartmanno,
        dairenobilgi: result[0].daireno
      });
    }
  });
});

//Birleştirilmiş API Adresleri

app.post('/arabaresimcek', (req, res) => {
  const { ruhsatseri_no } = req.body;
  const resimCek = 'SELECT image FROM araba_sahibi_modu INNER JOIN musteribilgileri, araba_bilgileri, adres WHERE ruhsatseri_no = ?';
  db.query(resimCek, [ruhsatseri_no], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      res.json({
        resimbilgi: result[0].image,
      });
    }
  });
});

app.post('/arababilgicek', (req, res) => {
  const { ruhsatseri_no } = req.body;
  const veriCek = 'SELECT * FROM araba_sahibi_modu JOIN araba_bilgileri ON araba_bilgileri.araba_id = araba_sahibi_modu.araba_id JOIN musteribilgileri ON araba_sahibi_modu.musteri_id = musteribilgileri.musteri_id JOIN adres ON musteribilgileri.adres_id = adres.adres_id WHERE ruhsatseri_no = ?';
  db.query(veriCek, [ruhsatseri_no], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      res.json({
        markabilgi: result[0].marka,
        modelbilgi: result[0].model,
        yilbilgi: result[0].yil,
        vitesbilgi: result[0].vites,
        kmbilgi: result[0].km,
        motor_gucubilgi: result[0].motor_gucu,
        yakitbilgi: result[0].yakit,
        hasar_kaydibilgi: result[0].hasar_kaydi,
        fiyatbilgi: result[0].fiyat,

        adbilgi: result[0].ad,
        soyadbilgi: result[0].soyad,
        telefonbilgi: result[0].telefon_no,


        sehirbilgi: result[0].il,
        ilcebilgi: result[0].ilce,
        mahallebilgi: result[0].mahalle,
        caddebilgi: result[0].cadde,
        sokakbilgi: result[0].sokak,
        apartmannobilgi: result[0].apartmanno,
      });
    }
  });
});
app.get('/ruhsatnumarasayisi', (req, res) => {
  const veriCek = 'SELECT ruhsatseri_no FROM araba_sahibi_modu';
  db.query(veriCek, (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      let ruhsatNumaralari = result.map(ruhsat => ruhsat.ruhsatseri_no);
      res.json(ruhsatNumaralari);
    }
  });
});


app.post('/odemebilgicek', (req, res) => {
  const { tc_kimlik } = req.body;
  const veriCek = 'SELECT kart_no, son_kullanma_tarihi, cvv FROM musteribilgileri JOIN odemebilgileri ON musteribilgileri.odeme_id = odemebilgileri.odeme_id WHERE tc_kimlik = ?';
  db.query(veriCek, [tc_kimlik], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0) {
      res.json({
        kartbilgi: result[0].kart_no,
        starihbilgi: result[0].son_kullanma_tarihi,
        cvvbilgi: result[0].cvv,
        butonpanel: false,
        bilgipanel: true,
      });
    }
    else {
      res.json({
        kartbilgi: "",
        starihbilgi: "",
        cvvbilgi: "",
        butonpanel: true,
        bilgipanel: false,
      });
    }
  });
});


/*const {ruhsatseri_no} = '456';
const veriCek = ' SELECT * FROM araba_sahibi_modu JOIN araba_bilgileri ON araba_sahibi_modu.araba_id = araba_bilgileri.araba_id WHERE ruhsatseri_no = ?';
db.query(veriCek, [ruhsatseri_no], (err, result) => {
  if(err){
    throw err;
  }
  if(result.length > 0){
 console.log(result[0].marka);
  }
}); */

//________________________________________________________________________________________________________________________

app.get('/tum_ruhsat_serileri', (req, res) => {
  const sql = 'SELECT ruhsatseri_no FROM araba_sahibi_modu';
  db.query(sql, (err, result) => {
    if (err) {
      throw err;
    }
    res.json(result.map(row => row.ruhsatseri_no));
  });
});

//_______________VERİ SİL_________________

app.post('/kullanicisil', (req, res) => {
  let arabaid, adresid, odemeid;
  const { ruhsatseri_no, tc_kimlik } = req.body;
  const arabaId_al = 'SELECT araba_id FROM araba_sahibi_modu WHERE ruhsatseri_no = ?';
  const adresId_al = 'SELECT adres_id FROM musteribilgileri WHERE tc_kimlik = ?';
  const odemeId_al = 'SELECT odeme_id FROM musteribilgileri WHERE tc_kimlik = ?';

  const sahipsil = 'DELETE FROM araba_sahibi_modu WHERE ruhsatseri_no = ?';
  const arabasil = 'DELETE FROM araba_bilgileri WHERE araba_id = ?';
  const musterisil = 'DELETE FROM musteribilgileri WHERE tc_kimlik = ?';
  const adressil = 'DELETE FROM adres WHERE adres_id = ?';
  const odemesil = 'DELETE FROM odemebilgileri WHERE odeme_id = ?';

  db.query(arabaId_al, [ruhsatseri_no], (arabaiderr, arabaidresult) => {
    if (arabaiderr) {
      throw arabaiderr;
    }
    if (arabaidresult.length > 0) {
      arabaid = arabaidresult[0].araba_id;

    }

    db.query(odemeId_al, [tc_kimlik], (odemeiderr, odemeidresult) => {
      if (odemeiderr) {
        throw odemeidresult;
      }
      if (odemeidresult.length > 0) {
        odemeid = odemeidresult[0].odeme_id;

      }

      db.query(adresId_al, [tc_kimlik], (adresiderr, adresidresult) => {
        if (adresiderr) {
          throw adresiderr;
        }
        if (adresidresult.length > 0) {
          adresid = adresidresult[0].adres_id;

        }

        if (arabaid != null) {
          db.query(sahipsil, [ruhsatseri_no]);
          db.query(arabasil, [arabaid]);
        }
        if (adresid != null) {
          db.query(musterisil, [tc_kimlik]);
          db.query(adressil, [adresid]);
        }
        if (odemeid != null) {
          db.query(odemesil, [odemeid]);
        }
      });
    });
  });
});
app.post('/arabasil', (req, res) => {
  let arabaid;
  const { ruhsatseri_no } = req.body;
  const arabaId_al = 'SELECT araba_id FROM araba_sahibi_modu WHERE ruhsatseri_no = ?';


  const sahipsil = 'DELETE FROM araba_sahibi_modu WHERE ruhsatseri_no = ?';
  const arabasil = 'DELETE FROM araba_bilgileri WHERE araba_id = ?';




  db.query(arabaId_al, [ruhsatseri_no], (arabaiderr, arabaidresult) => {
    if (arabaiderr) {
      throw arabaiderr;
    }
    if (arabaidresult.length > 0) {
      arabaid = arabaidresult[0].araba_id;
    }
    if (arabaid != null) {
      db.query(sahipsil, [ruhsatseri_no]);
      db.query(arabasil, [arabaid]);
    }
  });
});

