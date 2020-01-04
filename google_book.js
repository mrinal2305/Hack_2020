var express = require('express');
var request = require('request');
var port    = process.env.port || 3000;

const app = express();

//Array of object ,size 10 to store the filtered data
var output = [];

//Sending filtered Google Book data
app.get('/:input/',(req,res,next)=>{
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

    const url = "https://www.googleapis.com/books/v1/volumes?q="+input_modf+"&printType=books&orderBy=relevance&maxResults=15&key=AIzaSyC-7USJjf7fOg0-5FKR3PsnKeK9vh10JuE"; 
    console.log(url);

    request(url,(error,response,body)=>{
        if(!error && response.statusCode == 200){ // requesting unfiltered google book data
            //Main logic of code
            var data = JSON.parse(body);
            //check if present or not

            for (x of data.items){

            var tit,aut,publ,desc,iD,pC,img,cat,avgR;
            if(x.volumeInfo.title) tit = x.volumeInfo.title;
            else tit = 'null';
            if(x.volumeInfo.authors) aut = x.volumeInfo.authors;
            else aut = 'null';
            if(x.volumeInfo.publisher) publ = x.volumeInfo.publisher;
            else publ = 'null';
            if(x.volumeInfo.description) desc = x.volumeInfo.description;
            else desc = 'null';
            if(x.volumeInfo.industryIdentifiers) iD = x.volumeInfo.industryIdentifiers;
            else iD = 'null';
            if(x.volumeInfo.pageCount) pC = x.volumeInfo.pageCount;
            else pC = 'null';
            if(x.volumeInfo.imageLinks) img = x.volumeInfo.imageLinks;
            else img = 'null';
            if(x.volumeInfo.categories) cat = x.volumeInfo.categories;
            else cat = 'null';
            if(x.volumeInfo.averageRating) avgR = x.volumeInfo.averageRating;
            else avgR = 'null';

               var out = {
                   id           : x.id,
                   title        : tit,
                   author       : aut,
                   publisher    : publ,
                   description  : desc,
                   isbn         : iD,
                   pageCount    : pC,
                   imageLinks   : img,
                   categories   : cat,
                   averageRating: avgR
               }
               output.push(out);
            }
            res.send(output);
    }
});

});

app.listen(port,()=>{
    console.log('App listening on port'+port);
})
