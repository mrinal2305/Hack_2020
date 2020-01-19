var admin = require('firebase-admin');     //Admin access firebase

var serviceAccount = require("./serviceAccountKey");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://smart-library-55e4d.firebaseio.com"
  });

var db = admin.firestore(); //Our database

db.settings({ timestampsInSnapshots : true }) // Setting of database

module.exports = db;