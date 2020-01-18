import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AngularFirestore } from 'angularfire2/firestore';

@Component({
  selector: 'app-book-details',
  templateUrl: './book-details.component.html',
  styleUrls: ['./book-details.component.css']
})
export class BookDetailsComponent implements OnInit {
  id;
  data;
  constructor(public route : ActivatedRoute,public db:AngularFirestore) { }

  ngOnInit() {
    this.id = this.route.snapshot.queryParamMap.get('id');
    console.log(this.id);

    this.db.collection('book').doc(this.id).get().subscribe(val => {
      this.data = val.data();
      console.log(this.data);
    })
  }
  
}
