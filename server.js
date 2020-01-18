var express = require('express');
var app     = express();
var port    = process.env.PORT || 3000;

const conceptRoutes = require('./concept');
const emotionRoutes = require('./emotion');
const sentimentRoutes = require('./sentiment');
const subCategRoutes  = require('./subCategories');

// Allowing CORS 
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header(
      "Access-Control-Allow-Headers",
      "Origin, X-Requested-With, Content-Type, Accept, Authorization"
    );
    if (req.method === 'OPTIONS') {
        res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
        return res.status(200).json({});
    }
    next();
  });


app.get('/',(req,res,next)=>{
    res.send({
        message : "Add valid url"
    })
})

app.use('/concept',conceptRoutes);
app.use('/emotion',emotionRoutes);
app.use('/sentiment',sentimentRoutes);
app.use('/subCategory',subCategRoutes);

app.get('*',(req,res,next)=>{
    res.send({
        message : "Add valid url"
    })
})

app.listen(port,()=>{
    console.log("App is listening on port "+port);
})

// Add all four fn and return all as json