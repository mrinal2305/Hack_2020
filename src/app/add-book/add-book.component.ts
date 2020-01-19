import { Component, OnInit } from '@angular/core';
import { IsbnDetailsService } from './../isbn-details.service';

@Component({
  selector: 'app-add-book',
  templateUrl: './add-book.component.html',
  styleUrls: ['./add-book.component.css']
})


export class AddBookComponent implements OnInit {
  showTitle = true;
  showIsbn  = true;
  title ;
  title_data;
  isbn_data;
  isbn ;

  constructor(public db:IsbnDetailsService) { }

  Submit(){
   if(this.title == undefined) this.showTitle = false;

   if(this.isbn == undefined)  this.showIsbn  = false;
   
   if(this.showTitle){
     this.db.peaceful_title(this.title).subscribe(data => {
       this.title_data = data;
      //  console.log(this.title_data);
     })
   }

   if(this.showIsbn) {
     this.db.peaceful_isbn(this.isbn).subscribe(data=>{
       this.isbn_data = data;
       console.log(this.isbn_data);
     })
   }
  }

  ngOnInit() {  

  }
}
