import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import {IsbnDetailsService } from './../../isbn-details.service';

@Component({
  selector: 'app-full-detail',
  templateUrl: './full-detail.component.html',
  styleUrls: ['./full-detail.component.css']
})
export class FullDetailComponent implements OnInit {
  id;
  basic_details;
  category;
  ddc_lcc;
  concept;
  subCategory;
  obj_book; // obj to collection book
  obj_nlp; //obj to collection to NLP

  constructor(public route:ActivatedRoute,public db:IsbnDetailsService,public router:Router) { }
 
  click(){
    window.alert('Success');
    this.router.navigateByUrl('/');
  }
  ngOnInit() {
    this.id = this.route.snapshot.queryParamMap.get('id');
    // console.log(this.id);

    this.db.nameless_details(this.id).subscribe(val => { //Getting basic details
      this.basic_details = val;     // API TO GET DDC
      console.log(this.basic_details);

      // CALL HERE CATEGORY,DDC AND NLP
      var title = this.basic_details.title; console.log(this.concept)
      var desc  = this.basic_details.description;
      // Add title key

      // Call API to get category
      this.db.nameless_category(title).subscribe(val => {
        this.category = val;
        console.log(this.category.categories);
      })
      var ddc_array = [];
     
      //CALL API TO GET DDC
      this.db.nameless_ddc(title).subscribe(val => {
        // console.log(val);
        this.ddc_lcc = val;
        ddc_array.push(this.ddc_lcc[0].ddc);
        ddc_array.push(this.ddc_lcc[1].ddc);
        console.log(this.ddc_lcc);
      })
      // CALL API TO GET SUBCATEGORY,CONCEPT
  
      this.db.intense_concept(desc).subscribe(val => {
        this.concept = val;
        console.log(this.concept);  // SUBMIT TO FIRESTORE FROM HERE
      })
     

      this.db.intense_subCategory(desc).subscribe(val => {
         this.subCategory = val;
         console.log(this.subCategory); 
      })

        // // OBJ TO NLP
        // var objs = {
        //   concept : this.concept,
        //   subCategory :this.concept
        // }
  
        // console.log(objs)

      //OBJ TO BOOK
      var obj = {
        author :this.basic_details.author,
        ddc:ddc_array,
        description:this.basic_details.description,
        isbn_10:this.basic_details.isbn.isbn_10,
        isbn_13:this.basic_details.isbn.isbn_13,
       
        pageCount:this.basic_details.pageCount,
        rating :this.basic_details.averageRating,
        publisher:this.basic_details.publisher,
        smallThumbnail:this.basic_details.image.smallThumbnails,
        title:this.basic_details.title,
        titleKey:this.basic_details.title[0].toLowerCase()
      }
      this.obj_book = obj;
      console.log(obj);
   
    })

  }

}
