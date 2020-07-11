const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const korisnikSchema = new Schema({
    //username?
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true, minlength: 6 },
  doktor: { type: mongoose.Types.ObjectId, ref: 'Doktor' }
  //dodati required true
  //videti kako odraditi ovo, ili samo doktoru dodati username password da li je bolje?
});

module.exports = mongoose.model("Korisnik", korisnikSchema);
