import { Component, OnInit } from '@angular/core';
import { ActivatedRoute , Router} from '@angular/router';
import { AngularFirestore } from 'angularfire2/firestore';

@Component({
  selector: 'app-stu-info',
  templateUrl: './stu-info.component.html',
  styleUrls: ['./stu-info.component.css']
})
export class StuInfoComponent implements OnInit {
  studs = [];
  constructor(public route : ActivatedRoute,public db:AngularFirestore) {
    
   }

  ngOnInit() {
    // console.log(this.route.snapshot.queryParamMap.get('message'));  // GETTING VALUE
    this.db.collection('student').snapshotChanges().subscribe(snapshot => {  // REALTIME DATA 
      this.studs = []
       snapshot.forEach(x =>{
        this.studs.push(x.payload.doc.data());
       })
       console.log(this.studs)
     })
  }
  
  
}
