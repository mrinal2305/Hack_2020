import { Component, OnInit } from '@angular/core';
import { AngularFirestore } from 'angularfire2/firestore';

@Component({
  selector: 'app-reg-stu',
  templateUrl: './reg-stu.component.html',
  styleUrls: ['./reg-stu.component.css']
})
export class RegStuComponent implements OnInit {
  show = true;
  name : any;
  year: any;
  branch: any;
  rollno;
  regno: any;
  yoa: any;
  yop: any;
  adress: any;
  city: any;
  zip: any;
  email: any;
  password: any;
  success = false;
  error   = false;
  constructor(public db:AngularFirestore) { }

  ngOnInit() {
  }

  
  Submit(){
    var obj = {
      Name : this.name,
      Branch : this.branch,
      Year   : this.year,
      date_of_admisson : this.yoa,
      date_of_passing  : this.yop,
      reg_no : this.regno,
      roll :this.rollno,
      adress:this.adress,
      zip:this.zip,
    }

    this.email = this.rollno+'@nitp.ac.in';
    this.show = false;
     var id = this.rollno.toString();
     console.log(id);

    this.db.collection('student').doc(id).set(obj).then(()=>{
      console.log("success");
      this.success = true;

    }).catch(err => {
      console.log(err);
      this.success = true;
    })
  
  }

}
