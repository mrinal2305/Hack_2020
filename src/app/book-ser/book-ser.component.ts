import { Component, OnInit } from '@angular/core';
import { AngularFirestore } from 'angularfire2/firestore';
import { BookService } from './../book.service';
import { Subject } from 'rxjs';
import { combineLatest } from 'rxjs';

@Component({
  selector: 'app-book-ser',
  templateUrl: './book-ser.component.html',
  styleUrls: ['./book-ser.component.css']
})
export class BookSerComponent implements OnInit {
  data_obj = [] ; 
  searchterm : string;

  startAt = new Subject();
  endAt    = new Subject();
  

  startObs = this.startAt.asObservable();
  endObs   = this.endAt.asObservable();   

  constructor(public db:AngularFirestore) { }
 
  search($event){
    var q = $event.target.value;
    this.startAt.next(q);
    this.endAt.next(q + '\uf8ff');

  }

  firequery(start,end){
    return this.db.collection('book',ref => ref.orderBy('title').startAt(start).endAt(end)).valueChanges();
  }

  ngOnInit() {
    combineLatest(this.startObs, this.endObs).subscribe((value) => {
      this.firequery(value[0], value[1]).subscribe((books) => {
        this.data_obj = books;
    })
   
    })
    
    this.db.collection('book').snapshotChanges().subscribe(snapshot => {  // REALTIME DATA 
      this.data_obj = []
       snapshot.forEach(x =>{
        this.data_obj.push(x.payload.doc.data());
       })
      
     })
  }

}
