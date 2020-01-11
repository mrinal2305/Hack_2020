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
        if(response.statusCode == 404 || error) res.send({error : "Page not found"});
        if(!error && response.statusCode==200){
            var json = convert.xml2json(body,{compact:true})
            var output = JSON.parse(json);
            result = {
                title : output.GoodreadsResponse.book.title,
                author :output.GoodreadsResponse.book.authors.author,
                isbn   : {
                        isbn_10 : output.GoodreadsResponse.book.isbn,
                        isbn_13 : output.GoodreadsResponse.book.isbn13
                },
                image :  {
                    smallThumbnails : output.GoodreadsResponse.book.small_image_url,
                    thumbnail       : output.GoodreadsResponse.book.image_url,
                },
                publisher     : output.GoodreadsResponse.book.publisher,
                description   : output.GoodreadsResponse.book.description,
                pageCount     : output.GoodreadsResponse.book.num_pages,
                averageRating : output.GoodreadsResponse.book.average_rating,
                buyLinks      : output.GoodreadsResponse.book.buy_links.buy_link
            }
            res.send(result);
        }
    })
})

module.exports = router;
