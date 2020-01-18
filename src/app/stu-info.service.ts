import { Injectable } from '@angular/core';
import { AngularFirestore } from 'angularfire2/firestore';


@Injectable({
  providedIn: 'root'
})
export class StuInfoService {

  constructor(private db : AngularFirestore) { }

  // get_list(){
  //   this.db.collection('student')
  // }
}
