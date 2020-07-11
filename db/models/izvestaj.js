const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const izvestajSchema = new Schema({
  datum: { type: Date, required: true },
  dg: String,
  th: String,
  kontrola: String,
  doktor: { type: mongoose.Types.ObjectId, required: true, ref: "Doktor" },
});

module.exports = mongoose.model("Izvestaj", izvestajSchema);
