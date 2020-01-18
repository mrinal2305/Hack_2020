import { Component, OnInit } from '@angular/core';
import { AngularFirestore } from 'angularfire2/firestore';

@Component({
  selector: 'app-book-ser',
  templateUrl: './book-ser.component.html',
  styleUrls: ['./book-ser.component.css']
})
export class BookSerComponent implements OnInit {
  data_obj = [] ;    

  constructor(public db:AngularFirestore) { }
 
  ngOnInit() {
    this.db.collection('book').snapshotChanges().subscribe(snapshot => {  // REALTIME DATA 
      this.data_obj = []
       snapshot.forEach(x =>{
        this.data_obj.push(x.payload.doc.data());
       })
      
     })
  }

}
