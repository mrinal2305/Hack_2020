import { Component, OnInit } from '@angular/core';
import { AngularFireStorage } from 'angularfire2/storage';


@Component({
  selector: 'app-hompage',
  templateUrl: './hompage.component.html',
  styleUrls: ['./hompage.component.css']
})
export class HompageComponent implements OnInit {
  isActive = false;
  constructor(private afStorage: AngularFireStorage) { }
 
  ngOnInit() {
  }

  mouseEnter(){
    this.isActive = !this.isActive;
  }

  mouseLeave(){
    this.isActive = !this.isActive;
  }
}
