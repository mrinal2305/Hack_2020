const express = require("express");        //requiring express
const app = express();                     //declaring app
const bodyParser = require("body-parser"); //requiring body-parser

var stud_info = require('./stu_info');
var port      = process.env.PORT || 3000;  // declaring port

app.use(bodyParser.urlencoded({ extended: false }));  //using body-parser
app.use(bodyParser.json());                           //body-parser to parse json data

app.use((req, res, next) => {       // Accessing the header
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  );
  if (req.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "PUT, POST, PATCH, DELETE, GET");
    return res.status(200).json({});
  }
  next();
});

app.get('/',(req,res)=>{
  res.send({
    message : "Welcome to backend Api for Smart library app",
    detail  : "Add more ;/ URL"
  })
})

app.use('/stud_list',stud_info);

app.get('*',(req,res)=>{
  res.send({
    error : "Add Valid URL"
  })
})

app.listen(port,()=>{
  console.log('App is listening on port '+port);
})
