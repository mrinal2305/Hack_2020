// get basic student detail image and all in student app
// show all on basis of id in librarian app

var db = require('./fire_db');    // Declaring database
var express = require('express'); // requiring express
var router  =   express.Router(); // Declaring router

router.get('/',(req,res,body)=>{
  
 var data = [];
 db.collection

})  

router.post('/',(req,res)=>{
  var obj = {
    name   : req.body.name,
    branch : req.body.branch,
    roll   : req.body.roll,
    year   : req.body.year
  }
  db.collection('student').doc('1706004').set(obj).then(()=>{  // GREAT POST REQUEST

    res.send("Success");
    console.log("Success");
  })
  .catch((err)=>{
    res.send(err);
    console.log(err);
  });

  
})

router.delete('/:id',(req,res)=>{
  var id = req.params.id;
  db.collection('student').doc(id).delete().then(()=>{
    res.send('Successfully Deleted');	
  })
})

// var data = db.collection('student').doc('1706026');
// data.get().then((doc)=>console.log(doc.data()))       // Get request to single data



module.exports = router;
