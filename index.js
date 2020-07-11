const express = require("express");
const cors = require("cors");
const app = express();
const port = 8000;
const { connection } = require("./db/connection");
const Korisnik = require("./db/models/korisnik");
const UserRoute = require("./routes/UserRoute");
const mysql = require("mysql");
const { response } = require("express");
const jwt = require("jsonwebtoken");

app.use(cors());
app.use(express.json());
app.use(UserRoute);

app.listen("9000", () => {
  console.log("Server started on port 9000! ");
});

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "fpis",
});

db.connect(function (err) {
  if (err) throw err;
  console.log("Connected!");
});

app.post("/login", (req, res) => {
  let korisnik = { email: req.body.email, password: req.body.password };
  let sqlQuery = "SELECT email,password FROM korisnik WHERE email = ?";
  let execute = db.query(sqlQuery, korisnik.email, async (err, result) => {
    console.log(result);
    if (err) throw err;
    if (result && result.length) {
      jwt.sign({ exp: 7, data: result[0].email }, "marina", function (
        err,
        token
      ) {
        if (err) res.send(err);
        res.send({ token: token });
      });
    } else {
      res.send({ err: "Please sign up." });
    }
  });
});

app.post("/dodajkorisnika", (req, res) => {
  let korisnik = { email: req.body.email, password: req.body.password };
  let sql = "INSERT INTO korisnik SET ?";
  let query = db.query(sql, korisnik, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.send("Korisnik je kreiran");
  });
});

app.post("/dodajkorisnika", (req, res) => {
  let korisnik = { email: req.body.email, password: req.body.password };
  let sql = "INSERT INTO korisnik SET ?";
  let query = db.query(sql, korisnik, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.send("Korisnik je kreiran");
  });
});

app.get("/korisnici", (req, res) => {
  let sql = "SELECT * FROM korisnik";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send("Prikazani su korisnici");
  });
});

app.get("/korisnici/:id", (req, res) => {
  let sql = `SELECT * FROM korisnik WHERE korisnikid= ${req.params.id}`;
  let query = db.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.send("Prikazan je korisnik!");
  });
});

app.get("/kartoni", (req, res) => {
  let sql = "SELECT * FROM karton";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send(results);
  });
});

app.get("/kartoni/:id", (req, res) => {
  let sql = `SELECT * FROM karton WHERE kartonid=${req.params.id}`;
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send(results);
  });
});

app.get("/doktori", (req, res) => {
  let sql = "SELECT * FROM doktor";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send(results);
  });
});

app.get("/doktori/:id", (req, res) => {
  let sql = `SELECT * FROM doktor WHERE doktorid=${req.params.id}`;
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send("Prikazan je doktor");
  });
});

app.get("/rezultati", (req, res) => {
  let sql = "SELECT * FROM rezultat";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send(results);
  });
});

app.post("/addrezultat", (req, res) => {
  let rezultat = {
    posiljalac: req.body.posiljalac,
    datumupisa: req.body.datumupisa,
    uzorakid: req.body.uzorakid,
  };
  let sql = "INSERT INTO rezultat SET ?";
  let query = db.query(sql, rezultat, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.send("Rezultat je kreiran");
  });
});

app.get("/brisanjerezultata/:id", (req, res) => {
  let sql = `DELETE FROM rezultat WHERE rezultatid=${req.params.id}`;
  let query = db.query(sql, (err, result) => {
    if (err) throw err;
    res.send(result);
  });
});

app.post("/izmenarezultata/:id", (req, res) => {

  let sql = `UPDATE rezultat SET posiljalac='${req.body.posiljalac}', datumupisa='${req.body.datumupisa}', uzorakid=${req.body.uzorakid} WHERE rezultatid=${req.params.id}`;
  let query = db.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

app.get("/rezultati/:id", (req, res) => {
  let sql = `SELECT * FROM rezultat WHERE rezultatid=${req.params.id}`;
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send("Prikazan je rezultat");
  });
});

app.get("/parametri", (req, res) => {
  let sql = "SELECT * FROM parametar";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send(results);
  });
});

app.get("/parametri/:id", (req, res) => {
  let sql = `SELECT * FROM parametar WHERE parametarid=${req.params.id}`;
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send("Prikazan je parametar");
  });
});
//PAZI STA SALJES KAO RESPONSE!!!!!
app.get("/uzorci", (req, res) => {
  let sql =
    "SELECT u.kartonid, k.ime, k.prezime, u.uzorakid FROM uzorak u JOIN karton k ON (u.kartonid=k.kartonid)";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send(results);
  });
});

app.get("/uzorci/:id", (req, res) => {
  let sql = `SELECT * FROM uzorak WHERE uzorakid=${req.params.id}`;
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send("Prikazan je uzorak");
  });
});

app.get("/tipovi", (req, res) => {
  let sql = "SELECT * FROM tipuzorka";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
    res.send(results);
  });
});

app.get("/izvestaji", (req, res) => {
  let sql = "SELECT i.datumstampanja, i.izvestajid, i.napomena, d.ime as doktorIme, d.prezime as doktorPrezime, d.specijalnost, k.ime as kartonIme, k.prezime as kartonPrezime FROM izvestaj i INNER JOIN doktor d ON i.doktorid = d.doktorid INNER JOIN karton k ON k.kartonid = i.kartonid  ";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    res.send(results);
  });
});

app.get("/delete_izvestaj/:id", (req, res) => {
  let sql = `DELETE FROM izvestaj WHERE izvestajid=${req.params.id}`;
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    res.send(results);
  });
});

app.post("/dodajizvestaj", (req, res) => {
  
  let izvestaj = {
    kartonid: req.body.kartonid,
    datumstampanja: req.body.datumstampanja,
    napomena: req.body.napomena,
    doktorid: req.body.doktorid,
  };

  let sql1 = "INSERT INTO izvestaj SET ?";

  let query = db.query(sql1, izvestaj, (err, result) => {
    if (err) throw err;
    res.send("Izvestaj je kreiran, kao i stavke");


    let stavke = { stavke: req.body.stavke };
    let newArray = req.body.stavke.map((stavka, index) =>{
      return {...stavka, izvestajid: result.insertId, rb: index+1}
    })

    for (i = 0; i < newArray.length; i++) {
      let sql = "INSERT INTO stavkaizvestaja SET ?";

      let query = db.query(sql, newArray[i], (err, result) => {
        if (err) throw err;
        console.log(result);
      });
    }

  });




});

//connection();

// app.get("/korisnici", (req, res, next) => {
//   Korisnik.find({},(err,result) => {
//     res.send(result);
//   });
// });

// app.listen(port, () =>
//   console.log(`Example app listening at http://localhost:${port}`)
// );
