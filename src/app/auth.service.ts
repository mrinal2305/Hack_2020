import { Injectable } from '@angular/core';
import { AngularFireAuth } from 'angularfire2/auth';
import * as firebase from 'firebase/app';
import { ActivatedRoute } from '@angular/router';
import { AngularFirestore } from 'angularfire2/firestore';

import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  user: Observable<firebase.User>;
  res = false;
  constructor(private firebaseAuth: AngularFireAuth,private route : ActivatedRoute,public db : AngularFirestore) {
    this.user =firebaseAuth .authState;
  }

  // SIGN UP
  signup(email: string, password: string) {
    this.firebaseAuth
      .auth
      .createUserWithEmailAndPassword(email, password)
      .then(value => {
        console.log('Success!', value);
      })
      .catch(err => {
      
        console.log('Something went wrong:',err.message);
        window.alert(err.message);
      });    
      
  }

  // LOGIN
  login(email: string, password: string) {

    let returnUrl = this.route.snapshot.queryParamMap.get('returnUrl') || '/'; // STEP 2 : Saving that url

    localStorage.setItem('returnUrl',returnUrl);
    // console.log(returnUrl);     
    
     return this.firebaseAuth      //GREAT PRIYANSHU METHOD
      .auth
      .signInWithEmailAndPassword(email, password);
  }

  // LOGOUT
  logout() {
    this.firebaseAuth
      .auth
      .signOut();
      window.alert("Successfully logged out")
  }

  // CHECK SUPER USER/ LIBRARIAN
  superUser(){
    var id = localStorage.getItem('uid');
    if(id){
      this.db.collection('check').doc(id).get().subscribe(doc => {
         localStorage.setItem('isSuper',doc.data().isSuper); 
         localStorage.setItem('isLibrarian',doc.data().isLibrarian); 
      })
    }
  }

}