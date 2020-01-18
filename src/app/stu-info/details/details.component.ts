import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AngularFirestore } from 'angularfire2/firestore';


@Component({
  selector: 'app-details',
  templateUrl: './details.component.html',
  styleUrls: ['./details.component.css']
})
export class DetailsComponent implements OnInit {
  id : any;
  data ;
  constructor(public route : ActivatedRoute,public db:AngularFirestore) { }
  
  ngOnInit() {

   this.id = this.route.snapshot.queryParamMap.get('id'); // Getting URL send by previous browser
   console.log(this.id);
   
   this.db.collection('student').doc(this.id).get().subscribe(x => {
     this.data = x.data();
     console.log(this.data);
   });

  }

}
