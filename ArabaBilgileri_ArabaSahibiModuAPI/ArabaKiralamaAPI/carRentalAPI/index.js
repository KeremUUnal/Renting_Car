const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
const port = 3000;

const db = mysql.createConnection({
    host: '127.0.0.1',
    port: '3306',
    user: 'root',
    password: '*****',
    database: 'arabakiralama'
  });

  db.connect((err) => {
    if (err) {
      throw err;
    }
    console.log('MySQL bağlantısı başarılı!');
  });
  let yeni_musteri_id = 0;
  let kiralama_id = 100; 
  let odeme_id = 0;
  let sayac = 0; 
  let sayac2 = 0; 
let araba_sahibi_id = "AS" + sayac;
let araba_id = "AB" + sayac2;
 async function updateMaxIds() {
  const query1 = 'SELECT MAX(araba_sahibi_id) AS maxaraba_sahibi_id FROM araba_sahibi_modu';
  const query2 = 'SELECT MAX(araba_id) AS maxaraba_id FROM araba_bilgileri';
  const query3 = 'SELECT MAX(odeme_id) AS maxodeme_id FROM odemebilgileri';
  const query4 = 'SELECT MAX(kiralama_id) AS maxkiralama_id FROM kiralamabilgileri';

   await db.query(query1, (err, result) => {
    if (err) throw err;
    let maxId = result[0].maxaraba_sahibi_id || "AS0";
    sayac = parseInt(maxId.slice(2)); // "AS0" stringinin sonundaki sayıyı alır
  });


  await db.query(query2, (err, result) => {
    if (err) throw err;
    let maxId = result[0].maxaraba_id|| "AB0";
    sayac2 = parseInt(maxId.slice(2)); // "KUAS1" stringinin sonundaki sayıyı alır
  });
   
 await db.query(query3, (err, result) => {
    if (err) throw err;
    odeme_id = result[0].maxodeme_id || 0;
});

        
      
await db.query(query4, (err, result) => {
  if (err) throw err;
  kiralama_id = result[0].maxkiralama_id || 100;
});

}

updateMaxIds().then(() => {
  app.listen(port, () => {
    console.log('Sunucu ${port} portunda çalışıyor...');
  });
}).catch((err) => {
  console.log(err);
});

app.post('/arababilgileri', (req, res) => {
  // body-parser ile gelen verilere erişin
  const {marka, model, yil, vites, km, motor_gucu, yakit, hasar_kaydi, fiyat,} = req.body;
  let { image } = req.body; // Base64 formatında fotoğraf
  const sql = 'INSERT INTO araba_bilgileri (araba_id, marka, model, yil, vites, km, motor_gucu, yakit, hasar_kaydi, fiyat, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
  sayac2++; 
  araba_id = "AB" + sayac2; 
  // Sorguyu çalıştırma
  db.query(sql, [araba_id, marka, model, yil, vites, km, motor_gucu, yakit, hasar_kaydi, fiyat, image], (err, result) => {
    if (err) {
      throw err;
    }
    res.json(result);
  });
});

app.post('/arababilgicek', (req, res) => {
  const {ruhsatseri_no} = req.body;
  const veriCek = ' SELECT * FROM araba_bilgileri JOIN araba_sahibi_modu ON araba_sahibi_modu.araba_id = araba_bilgileri.araba_id JOIN musteribilgileri ON araba_sahibi_modu.musteri_id = musteribilgileri.musteri_id JOIN adres ON adres.adres_id = musteribilgileri.adres_id WHERE ruhsatseri_no = ? '
  
  db.query(veriCek, [ruhsatseri_no], (err, result) => {
    if(err){
      throw err;
    }
    if(result.length > 0){
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
        resimbilgi: result[0].image,
       
        adbilgi: result[0].ad,
        soyadbilgi: result[0].soyad,
        telefonbilgi: result[0].telefon_no,
        
        
        sehirbilgi: result[0].il,
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


const {ruhsatseri_no} = '456';
const veriCek = ' SELECT * FROM araba_sahibi_modu JOIN araba_bilgileri ON araba_sahibi_modu.araba_id = araba_bilgileri.araba_id WHERE ruhsatseri_no = ?';
db.query(veriCek, [ruhsatseri_no], (err, result) => {
  if(err){
    throw err;
  }
  if(result.length > 0){
 console.log(result[0].marka);
  }
  
}); 



  app.post('/arabasahibibilgileri', (req, res) => {
    // body-parser ile gelen verilere erişin
    const {iban,  kasko_no, ruhsatseri_no } = req.body;
    const sql = 'INSERT INTO araba_sahibi_modu (araba_sahibi_id,  araba_id,  iban,  kasko_no, ruhsatseri_no) VALUES (?, ?, ?, ?, ?)';
    sayac++;
    araba_sahibi_id = "AS" + sayac; 
  
    // Sorguyu çalıştırma
    db.query(sql, [araba_sahibi_id,  araba_id,  iban,  kasko_no, ruhsatseri_no], (err, result) => {
      if (err) {
        throw err;
      }
      res.json(result);
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
       
        res.json(result);
      });
      
    });

   
    app.post('/kiralamabilgileri', (req, res) => {
      const { baslangic_tarihi, bitis_tarihi} = req.body;
  
      const sql = 'INSERT INTO kiralamabilgileri (kiralama_id, baslangic_tarihi, bitis_tarihi ) VALUES (?, ?, ?)';
      kiralama_id++;
      db.query(sql, [kiralama_id,baslangic_tarihi, bitis_tarihi], (err, result) => {
          if (err) {
              throw err;
          }
         
          res.json(result);
        });
        
      });
      
       
      
      
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
    const { kasko_no} = req.body;
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

