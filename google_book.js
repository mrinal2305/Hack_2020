var express = require('express');
var request = require('request');
var port    = process.env.PORT || 3000;
var convert  = require('xml-js');
const app   = express();

app.get('/',(req,res,next)=>{
    res.status(200).json({message : "Add title_author or isbn"});
})

app.get('/title_author',(req,res,next)=>{
    res.status(200).json({message : "Author author or title"})
})

//Sending filtered Google Book data
app.get('/title_author/:input/',(req,res,next)=>{
    //Array of object ,size 10 to store the filtered data
    var output = [];

    var input = req.params.input;   // taking title or author or isbn as optional parameter
    var input_modf = "";            // formatted input

    var i=0;
    while(i<input.length){             //formatted input logic
    if(input[i]==" ") {
        input_modf = input_modf+'+';
    }
    else input_modf = input_modf+input[i];
    i++;
    }

    const url = "https://www.googleapis.com/books/v1/volumes?q="+input_modf+"&printType=books&orderBy=relevance&maxResults=10&key=AIzaSyC-7USJjf7fOg0-5FKR3PsnKeK9vh10JuE"; 

    request(url,(error,response,body)=>{
        if(!error && response.statusCode == 200){ // requesting unfiltered google book data
            //Main logic of code
            var data = JSON.parse(body);
            //check if present or not

            for (x of data.items){

            var tit,aut,iD,img;
            if(x.volumeInfo.title) tit = x.volumeInfo.title;
            else tit = 'null';

            if(x.volumeInfo.authors) aut = x.volumeInfo.authors;
            else aut = 'null';
           
            if(x.volumeInfo.industryIdentifiers) iD = x.volumeInfo.industryIdentifiers;
            else iD = 'null';
           
            if(x.volumeInfo.imageLinks) img = x.volumeInfo.imageLinks;
            else img = 'null';
        
               var out = {
                  
                   "title"        : tit,
                   "author"       : aut,
                   "isbn"         : iD,
                   "imageLinks"   : img,
               }
               output.push(out);
            }
            res.send(output);
    }
    else{
        res.send({
            error : 'No Page found'
        })
    }
});

});

app.get('/isbn',(req,res,next)=>{
    res.send({
        message : "Write book isbn number"
    });
})

app.get('/isbn/:isbn',(req,res,next)=>{
    var isbn = req.params.isbn;
    var url = 'http://www.goodreads.com/book/isbn/'+isbn+'?key=ifarwBcSBlBsKGwcF5wLQ';
    request(url,(error,response,body)=>{
        if(!error && response.statusCode == 200){
            var json = convert.xml2json(body,{compact:true})
            var output = JSON.parse(json);
            
            data = {
                title : output.GoodreadsResponse.book.title,
                author :output.GoodreadsResponse.book.authors.author,
                isbn   : {
                        isbn_10 : output.GoodreadsResponse.book.isbn,
                        isbn_13 : output.GoodreadsResponse.book.isbn13
                },
                image :  {
                    smallThumbnails : output.GoodreadsResponse.book.small_image_url,
                    thumbnail       : output.GoodreadsResponse.book.image_url,
                }
            }
            res.send(data);
            
        }
    })
})

app.get("*",(req,res,next)=>{
    res.status(200).json({
        message : "No Page Found",
        error   : "Add valid URL name"
    })
})

app.listen(port,()=>{
    console.log('App listening on port'+port);
})
