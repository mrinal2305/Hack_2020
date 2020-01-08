var express = require('express');
var router  = express.Router();
var request = require('request');

router.get('/',(req,res,next)=>{
    res.send({
        message : "Add book title or book author"
    })
})

router.get('/:title_author',(req,res,next)=>{
    var title_author = req.params.title_author;
    url = 'https://peaceful-river-61209.herokuapp.com/title_author/'+title_author;
    request(url,(error,response,body)=>{
        var data = JSON.parse(body);
        var category = [];
        for(x of data){
        if(x.categories[0] != 'n') category.push(x.categories[0]);
        }
        res.send({
            message : 'These are most relevant category of '+ title_author,
            categories : category
        })
    })
})

module.exports = router;