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
            console.log(data.length);
            for (x of data.items){

            var tit,aut,iD,img,cat;
            if(x.volumeInfo.title) tit = x.volumeInfo.title;
            else tit = 'null';

            if(x.volumeInfo.authors) aut = x.volumeInfo.authors;
            else aut = 'null';
            var id_10 ,id_13;
            if(x.volumeInfo.industryIdentifiers) {
                iD = x.volumeInfo.industryIdentifiers;
                if(iD[0]) id_10 = iD[0].identifier;
                else id_10 = 'null';
                if(iD[1]) id_13 = iD[1].identifier;
                else id_13 = 'null';
                
            }
            else iD = 'null';
           
            if(x.volumeInfo.imageLinks) img = x.volumeInfo.imageLinks;
            else img = 'null';
        
            if(x.volumeInfo.categories) cat = x.volumeInfo.categories;
            else cat = 'null';


               var out = {
                  
                   "title"        : tit,
                   "author"       : aut[0],
                   "isbn"         : {
                       isbn_10 : id_10,
                       isbn_13 : id_13
                   },
                   "imageLinks"   : img,
                   "categories"   : cat
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

        if(response.statusCode == 404 || error) res.send({error : "Page not found"});

        if(!error && response.statusCode == 200){
            var json = convert.xml2json(body,{compact:true})
            var output = JSON.parse(json);
            var title;
            if(output.GoodreadsResponse.book.title._cdata) title = output.GoodreadsResponse.book.title._cdata;
            if(output.GoodreadsResponse.book.title._text) title = output.GoodreadsResponse.book.title._text;       
            
            data = {
                title : title,
                author :output.GoodreadsResponse.book.authors.author.name._text,
                isbn   : {
                        isbn_10 : output.GoodreadsResponse.book.isbn._cdata,
                        isbn_13 : output.GoodreadsResponse.book.isbn13._cdata
                },
                image :  {
                    smallThumbnail : output.GoodreadsResponse.book.small_image_url._text,
                    thumbnail       : output.GoodreadsResponse.book.image_url._text,
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
