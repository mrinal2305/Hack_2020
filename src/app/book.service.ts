import { Injectable } from '@angular/core';
import { AngularFirestore } from 'angularfire2/firestore';

@Injectable({
  providedIn: 'root'
})
export class BookService {

  constructor(public db:AngularFirestore) { }
  // It contain crud operation for Managing Book
  //Add Book

  //Update Book

  //Get Book
  get_book(){
    return this.db.collection('book')
  }

  //Delete Book
}
