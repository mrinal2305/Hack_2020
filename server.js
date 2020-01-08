const express = require('express');
const http    = require('http');
const app     = express();
const port    = process.env.PORT || 3000;
const request = require('request-promise');
var convert = require('xml-js');

var detailsRoutes  = require('./details');
var categoryRoutes = require('./category');
var ddcRoutes      = require('./ddc');

app.get('/',(req,res,next)=>{
    res.send({
        message : 'Add  /details or /ddc_lcc or /category'
    })
})

//API to get all book details using GoodReads api
app.use('/details',detailsRoutes);
//API to get categories
app.use('/category',categoryRoutes);
//API to get ddc number
app.use('/ddc_lcc',ddcRoutes);

app.get('*',(req,res,next)=>{
    res.send({
        error : 'Add valid URL'
    })
})


app.listen(port,()=>{
    console.log("App is listening on port "+port);
});