import { Component, OnInit } from '@angular/core';
import { AngularFirestore } from 'angularfire2/firestore';

@Component({
  selector: 'app-reg-mem',
  templateUrl: './reg-mem.component.html',
  styleUrls: ['./reg-mem.component.css']
})
export class RegMemComponent implements OnInit {
  show = true;
  name : any;
  post;
  regno: number;
  yoa: any;
  yop: any;
  adress: any;
  city: any;
  zip: any;
  email: any;
  password: any;
  inlineRadioOptions;
  success = false;
  error   = false;
  isLibrarian = false;
  isSuperUser = false;

  constructor(public db:AngularFirestore) { }

  Submit(){
    var obj = {
      Name : this.name,
      Post : this.post,
      date_of_joining : this.yoa,
      date_of_retirement  : this.yop,
      reg_no : this.regno,
      adress:this.adress,
      zip:this.zip,
      isLibrarian : this.isLibrarian,
      isSuperUser : this.isSuperUser
    }
   

    if(this.inlineRadioOptions == 'lib') {this.isLibrarian = true;}
    else {this.isSuperUser = true;}

    this.email = this.regno+'@nitp.ac.in';
    this.show = false;
    var id = this.regno.toString();

     console.log(obj);

    this.db.collection('librarian').doc(id).set(obj).then(()=>{
      console.log("success");
      this.success = true;

    }).catch(err => {
      console.log(err);
      this.error = true;
    })
  
  }

  ngOnInit() {
  }

}
