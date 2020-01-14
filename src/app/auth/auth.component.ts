import { Component,OnInit } from '@angular/core';
import { AuthService } from './../auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-auth',
  templateUrl: './auth.component.html',
  styleUrls: ['./auth.component.css']
})
export class AuthComponent implements OnInit{
  email    : string;
  password : string;  
  
  constructor(public authService : AuthService,private route : Router) { }

  // SIGN UP
  signup() {
    this.authService.signup(this.email, this.password);
    this.email = this.password = '';
  }
  
  // LOGIN
  login() {
    this.authService.login(this.email, this.password).then(value => {  // .then and .catch GREAT PRIYANSHU METHOD 
  
     console.log(value.user);
     localStorage.setItem('uid',value.user.uid);
      let returnUrl = localStorage.getItem('returnUrl');  // Getting the URL
      
      this.route.navigateByUrl(returnUrl); // if return URL sending to url

    }).catch(err => {
      console.log(err);
    });
    this.email = this.password = '';
  }
  // LOGOUT
  logout() {
    localStorage.removeItem('uid');
    this.authService.logout();
  }

  ngOnInit(){
    
  }

}
