const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const doktorSchema  = new Schema({
    ime: {type: String, required: true},
    prezime: {type: String, required: true},
    JMBG: {type: String, required: true},
    specijalnost: {type: String, required: true}
});

module.exports = mongoose.model('Doktor', doktorSchema);