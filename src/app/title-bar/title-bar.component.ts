import { Component, OnInit } from '@angular/core';
import {FormControl, Validators} from '@angular/forms';

@Component({
  selector: 'app-title-bar',
  templateUrl: './title-bar.component.html',
  styleUrls: ['./title-bar.component.css']
})

export class TitleBarComponent implements OnInit {
  showFiller = false;
  show  : boolean = false;
  emailFormControl = new FormControl('', [
    Validators.required,
    Validators.email,
  ]);

  constructor() { }
  
  onClick(){
    if(this.show == false) this.show = true;
    else this.show = false;
    console.log(this.show)
  }

  ngOnInit() {
    console.log(this.show);
  }

}
