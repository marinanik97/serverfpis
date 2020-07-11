// const mongoose = require('mongoose');

// module.exports.connection = () =>{
//     mongoose.connect('mongodb://localhost:27017/myapp', {useNewUrlParser: true}, () =>{
//     console.log('connected');
// });
// }
var mysql      = require('mysql');
var con = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '',
  database : 'fpis'
});
 
 
con.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
  });

module.exports = {
    con
}