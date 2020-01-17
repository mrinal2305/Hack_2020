import { Component, OnInit } from '@angular/core';
import { AuthService } from './auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit{

  constructor(public authService : AuthService){
    this.authService.superUser(); // Setting isSuper / isLibrarian value
  }

  ngOnInit(){
   
  }
   
}