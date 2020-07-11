const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const kartonSchema  = new Schema({
    ime: {type: String, required: true},
    prezime: {type: String, required: true},
    JMBG: {type: String, required: true},
    pol: {type: String, required: true},
    datumRodjenja: {type: Date, required: true},
    telefon: {type: String, required: true},
    email: {type: String, required: true},
    izvestaji: [{ type: mongoose.Types.ObjectId, ref: 'Izvestaj' }] 
    // required: true,
});

module.exports = mongoose.model('Karton', kartonSchema);