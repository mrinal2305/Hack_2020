import { Component, OnInit } from '@angular/core';
import { BookService } from './../book.service';
import { Subject } from 'rxjs';
import { combineLatest } from 'rxjs';
import { AngularFirestore } from 'angularfire2/firestore';

@Component({
  selector: 'app-man-book',
  templateUrl: './man-book.component.html',
  styleUrls: ['./man-book.component.css']
})
export class ManBookComponent implements OnInit {
  data_obj = [] ;                     // SEARCHING ON BASIS OF TITLE IS DONE, DO SEARCHING ON BASIS OF AUTHOR and DO CSS
  searchterm : string;

  startAt = new Subject();
  endAt    = new Subject();
  


  startObs = this.startAt.asObservable();
  endObs   = this.endAt.asObservable();
  
  constructor(public db:BookService,public afs:AngularFirestore) { }

      
  search($event){
    var q = $event.target.value;
    this.startAt.next(q);
    this.endAt.next(q + '\uf8ff');

  }

    firequery(start,end){
    return this.afs.collection('book',ref => ref.orderBy('title').startAt(start).endAt(end)).valueChanges();
  }

  ngOnInit() {
   
    combineLatest(this.startObs, this.endObs).subscribe((value) => {
      this.firequery(value[0], value[1]).subscribe((books) => {
        this.data_obj = books;
    })
   
    })

    this.db.get_book().snapshotChanges().subscribe(snapshot => {  // REALTIME DATA 
    this.data_obj = []
     snapshot.forEach(x =>{
      this.data_obj.push(x.payload.doc.data());
     })
   })

  }

}