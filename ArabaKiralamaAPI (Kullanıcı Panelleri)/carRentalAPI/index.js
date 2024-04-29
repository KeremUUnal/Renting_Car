const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
const port = 3000;

const db = mysql.createConnection({
  host: '**********',
  port: '*****',
  user: '*****',
  password: '********',
  database: 'car_rental'
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

// Veritabanından mevcut en yüksek adres_id ve musteri_id'yi sorgula ve güncelle
async function updateMaxIds() {
  const query1 = 'SELECT MAX(adres_id) AS maxAdresId FROM adres';
  const query2 = 'SELECT MAX(musteri_id) AS maxMusteriId FROM musteribilgileri';

  await db.query(query1, (err, result) => {
    if (err) throw err;
    adres_id = result[0].maxAdresId || 0;
  });

  await db.query(query2, (err, result) => {
    if (err) throw err;
    let maxId = result[0].maxMusteriId || "KU0";
    sayac = parseInt(maxId.slice(2)); // "KU1" stringinin sonundaki sayıyı alır
  });
}

updateMaxIds().then(() => {
  app.listen(port, () => {
    console.log(`Sunucu ${port} portunda çalışıyor...`);
  });
}).catch((err) => {
  console.log(err);
});

app.post('/tckontrol', (req, res) => {
  const {tc_kimlik} = req.body;
  const checkSql = 'SELECT tc_kimlik FROM musteribilgileri WHERE tc_kimlik = ?';

  db.query(checkSql, [tc_kimlik], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0 && result[0].tc_kimlik === tc_kimlik) {
      res.json({ message: 'Girdiğiniz T.C. kimlik numarası daha önce kullanılmış.' });
    
    } else {
      res.json({message: ''});
    }
  });
});
app.post('/ehliyetkontrol', (req, res) => {
  const {ehliyet_serino} = req.body;
  const checkSql = 'SELECT ehliyet_serino FROM musteribilgileri WHERE ehliyet_serino = ?';

  db.query(checkSql, [ehliyet_serino], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0 && result[0].ehliyet_serino === ehliyet_serino) {
      res.json({ message: 'Girdiğiniz seri numarası, kimlik bilgilerinizdeki ile uyuşmuyor.' });
    } else {
      res.json({message: ''});
    }
  });
});

app.post('/telkontrol', (req, res) => {
  const {telefon_no} = req.body;
  const checkSql = 'SELECT telefon_no FROM musteribilgileri WHERE telefon_no = ?';
  db.query(checkSql, [telefon_no], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.length > 0 && result[0].telefon_no === telefon_no) {
      res.json({ message: 'Girdiğiniz telefon numarası zaten kullanılmış.' });
    } else {
      res.json({message: ''});
    }
  });
});

app.post('/mailkontrol', (req, res) => {
  // body-parser ile gelen verilere erişin
  const {email} = req.body;

  // Öncelikle, e-posta adresinin zaten kullanılıp kullanılmadığını kontrol edin
  const checkSql = 'SELECT email FROM musteribilgileri WHERE email = ?';

  db.query(checkSql, [email], (err, result) => {
    if (err) {
      throw err;
    }

    // Eğer sonuç döndürürse, bu e-posta adresi zaten kullanılmış demektir
    if (result.length > 0 && result[0].email === email) {
      res.json({ message: 'Girdiğiniz e-posta adresi zaten kullanılmış.' });
    } else {
      // E-posta adresi kullanılmamışsa, kullanıcıya bu bilgiyi döndürün
      res.json({ message: '' });
    }
  });
});

app.post('/kullanicibilgicek', (req, res) => {
  const {tc_kimlik} = req.body;
  const veriCek = 'SELECT * FROM musteribilgileri WHERE tc_kimlik = ?';
  db.query(veriCek, [tc_kimlik], (err, result) => {
    if(err){
      throw err;
    }
    if(result.length > 0){
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
  const {tc_kimlik} = req.body;
  const veriCek = 'SELECT * FROM adres JOIN musteribilgileri ON musteribilgileri.adres_id = adres.adres_id WHERE tc_kimlik = ?';
  db.query(veriCek, [tc_kimlik], (err, result) => {
    if(err){
      throw err;
    }
    if(result.length > 0){
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

app.post('/kisiselbilgiler', (req, res) => {
  // body-parser ile gelen verilere erişin
  const { ad, soyad, tc_kimlik, cinsiyet, dogum_tarihi, ehliyet_serino, telefon_no, email, sifre } = req.body;
  const sql = 'INSERT INTO musteribilgileri (musteri_id, ad, soyad, tc_kimlik, cinsiyet, dogum_tarihi, ehliyet_serino, telefon_no, email, adres_id, sifre) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
  sayac++;
  musteri_id = "KU" + sayac;


  // Sorguyu çalıştırma
  db.query(sql, [musteri_id, ad, soyad, tc_kimlik, cinsiyet, dogum_tarihi, ehliyet_serino, telefon_no, email, adres_id, sifre], (err, result) => {
    if (err) {
      throw err;
    }
    res.json(result);
  });
});

app.post('/sifredegistir', (req, res) => {
  const { sifre, tc_kimlik } = req.body;
  const sql = 'UPDATE musteribilgileri SET sifre = ? WHERE tc_kimlik = ?';
  db.query(sql, [sifre, tc_kimlik], (err, result) => {
    if (err) { throw err; }
    else {
      if(result.length > 0){
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
      if(result.length > 0){
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
      if(result.length > 0){
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
      if(result.length > 0){
        res.json(result);
      }
    }
  });
});