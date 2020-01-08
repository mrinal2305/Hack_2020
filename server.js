var express = require('express');
var app     = express();
var port    = process.env.PORT || 3000;

const conceptRoutes = require('./concept');
const emotionRoutes = require('./emotion');
const sentimentRoutes = require('./sentiment');
const subCategRoutes  = require('./subCategories');

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