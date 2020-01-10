import { Component } from '@angular/core';
import { AuthService } from './../auth.service';

@Component({
  selector: 'app-auth',
  templateUrl: './auth.component.html',
  styleUrls: ['./auth.component.css']
})
export class AuthComponent{
  email    : string;
  password : string;  
  constructor(public authService : AuthService) { }
  // SIGN UP
  signup() {
    this.authService.signup(this.email, this.password);
    this.email = this.password = '';
  }
  // LOGIN
  login() {
    this.authService.login(this.email, this.password);
    this.email = this.password = '';    
  }
  // LOGOUT
  logout() {
    this.authService.logout();
  }

}
