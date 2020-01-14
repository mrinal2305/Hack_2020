import { Component,OnInit } from '@angular/core';
import { AuthService } from './../auth.service';
import { Router } from '@angular/router';
import { AngularFirestore } from 'angularfire2/firestore';

@Component({
  selector: 'app-auth',
  templateUrl: './auth.component.html',
  styleUrls: ['./auth.component.css']
})
export class AuthComponent implements OnInit{
  email    : string;
  password : string;  
  err      : any;  // Error showned

  constructor(public authService : AuthService,private route : Router,public db:AngularFirestore) { }

  // SIGN UP
  signup() {
    this.authService.signup(this.email, this.password);
    this.email = this.password = '';
  }

  //Remove mail
  remove_mail(text){
    var email = '';
    for(var i=0;i<7;i++){
      this.email = this.email + text[i];
    }
    return email;
  }
  
  // LOGIN
  login() {
    this.authService.login(this.email, this.password).then(value => {  // .then and .catch GREAT PRIYANSHU METHOD 
     let uid = value.user.uid; //Getting User data
     let email = value.user.email; // Getting email
     let roll = '';   // Generating roll
     
     let isSuper     = ''; // You can add this during form submisson and can make true/false
     let isLibrarian = ''; // You can add this during form submisson and can make true/false
   
     
     //Finding roll no
     for(var i=0;i<7;i++){
      roll = roll + email[i];
    }

      localStorage.setItem('uid',uid);                       // Setting item in local storage
      let returnUrl = localStorage.getItem('returnUrl');     // Getting the URL
      // console.log(returnUrl);                             // STEP 3 : Getting the setted URL
      
      //Checking if user is present and if not saving the data
      this.db.collection('check').doc(uid).get().subscribe(doc =>{
        
        if(!doc.data()) {                                //Checking if data is present or not
          this.db.collection('check').doc(uid).set({roll : roll}).then(()=>console.log("Data Saved")); 
        }

      });

      // Exporting data
    
      // redirecting to URL
      this.route.navigate([returnUrl],{queryParams : {message: "success" }});   // SEND VALUE SUCCESS
      // this.route.navigateByUrl(returnUrl) ; 

    }).catch(err => {         // GREAT WAY TO CATCH ERROR 
      this.err = err;
    });
    this.email = this.password = '';
  }

  // LOGOUT
  logout() {
    localStorage.removeItem('uid');
    localStorage.removeItem('isLibrarian');
    localStorage.removeItem('isSuper');
    this.authService.logout();
    this.route.navigateByUrl('/');
  }

  ngOnInit(){
    
  }

}
