var express = require('express');
var router  = express.Router();
var request = require('request');
var convert  = require('xml-js');

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
        var isbn = [];      
        for(x of data){
        if(x.isbn[0].type != "OTHER") {
        if(x.isbn[1].identifier != 'n') isbn.push(x.isbn[1].identifier);
        }
        }
       
        var ddc = []; //ddc array
        // LOGIC for ddc finding
        for(x of isbn){
            var isbn = x;
            url = 'http://classify.oclc.org/classify2/Classify?isbn='+isbn+'&summary=true';

            request(url,(error,response,body)=>{                
                    var json = convert.xml2json(body,{compact :true});
                    var output = JSON.parse(json);
                // checking if then ddc the sending
                if(output.classify.recommendations) {
                    var result = {
                        ddc : output.classify.recommendations.ddc.mostPopular._attributes.sfa,
                        lcc : output.classify.recommendations.lcc.mostPopular._attributes.sfa
                    }
                    ddc.push(result);
                    console.log("finally"+result);
                }
            })
        }
        function myFunc() {
            res.send(ddc);
            console.log(ddc);
          }
          setTimeout(myFunc, 2000);
    })
})


module.exports = router;