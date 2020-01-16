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

            var title,desc,namepublisher,pC,avgR,author;

            if(output.GoodreadsResponse.book.authors.author.name._text)  author = output.GoodreadsResponse.book.authors.author.name._text;
            else if(output.GoodreadsResponse.book.authors.author.name._cdata) author = output.GoodreadsResponse.book.authors.author.name._cdata;
            else author = 'null';

            if(output.GoodreadsResponse.book.title._text) title = output.GoodreadsResponse.book.title._text;
            else if(output.GoodreadsResponse.book.title._cdata) title = output.GoodreadsResponse.book.title._cdata;
            else title = 'null';

            if(output.GoodreadsResponse.book.description._cdata) desc = output.GoodreadsResponse.book.description._cdata;
            else if(output.GoodreadsResponse.book.description._text) desc = output.GoodreadsResponse.book.description._text;
            else desc = 'null';

            if(output.GoodreadsResponse.book.num_pages._cdata) pC = output.GoodreadsResponse.book.num_pages._cdata;
            else if(output.GoodreadsResponse.book.num_pages._text)  pC = output.GoodreadsResponse.book.num_pages._text;
            else pC = 'null';

            if(output.GoodreadsResponse.book.publisher._cdata) publisher = output.GoodreadsResponse.book.publisher._cdata;
           else if(output.GoodreadsResponse.book.publisher._text)  publisher = output.GoodreadsResponse.book.publisher._text;
            else publisher = 'null';

            if(output.GoodreadsResponse.book.average_rating._cdata) avgR = output.GoodreadsResponse.book.average_rating._cdata;
            else if(output.GoodreadsResponse.book.average_rating._text) avgR = output.GoodreadsResponse.book.average_rating._text;
            else avgR = 'null';

            result = {
                title  : title,
                author : output.GoodreadsResponse.book.authors.author.name._text,   // Retuning array check array and response 
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
