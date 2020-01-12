//Get book details using good reads book api
var express = require('express');
var router  = express.Router();
var request = require('request');
var convert  = require('xml-js');

router.get('/',(req,res,next)=>{
    res.send({
        message : 'Add isbn no'
    })
})

router.get('/:isbn',(req,res,next)=>{
    var isbn = req.params.isbn;
    var url = 'http://www.goodreads.com/book/isbn/'+isbn+'?key=ifarwBcSBlBsKGwcF5wLQ';
    request(url,(error,response,body)=>{
        if(response.statusCode == 404 ) res.send({error : "Page not found"});
        if(!error && response.statusCode == 200){
            var json = convert.xml2json(body,{compact:true})
            var output = JSON.parse(json);

            var title,desc,publisher,pC,avgR;

            if(output.GoodreadsResponse.book.title._text) title = output.GoodreadsResponse.book.title._text;
            if(output.GoodreadsResponse.book.title._cdata) title = output.GoodreadsResponse.book.title._cdata;

            if(output.GoodreadsResponse.book.description._cdata) desc = output.GoodreadsResponse.book.description._cdata;
            if(output.GoodreadsResponse.book.description._text) desc = output.GoodreadsResponse.book.description._text;

            if(output.GoodreadsResponse.book.num_pages._cdata) pC = output.GoodreadsResponse.book.num_pages._cdata;
            if(output.GoodreadsResponse.book.num_pages._text)  pC = output.GoodreadsResponse.book.num_pages._text;

            if(output.GoodreadsResponse.book.publisher._cdata) publisher = output.GoodreadsResponse.book.publisher._cdata;
            if(output.GoodreadsResponse.book.publisher._text)  publisher = output.GoodreadsResponse.book.publisher._text;

            if(output.GoodreadsResponse.book.average_rating._cdata) avgR = output.GoodreadsResponse.book.average_rating._cdata;
            if(output.GoodreadsResponse.book.average_rating._text) avgR = output.GoodreadsResponse.book.average_rating._text;
            result = {
                title : title,
                author :output.GoodreadsResponse.book.authors.author.name,
                isbn   : {
                        isbn_10 : output.GoodreadsResponse.book.isbn._cdata,
                        isbn_13 : output.GoodreadsResponse.book.isbn13._cdata
                },
                image :  {
                    smallThumbnails : output.GoodreadsResponse.book.small_image_url._text,
                    thumbnail       : output.GoodreadsResponse.book.image_url._text,
                },
                publisher     : publisher,
                description   : desc,
                pageCount     : pC,
                averageRating : avgR,
                buyLinks      : output.GoodreadsResponse.book.buy_links.buy_link
            }
            res.send(result);
        }
    
    })
})

module.exports = router;
