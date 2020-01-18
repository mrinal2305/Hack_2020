import { Component, OnInit } from '@angular/core';
import { IsbnDetailsService } from './../isbn-details.service';
@Component({
  selector: 'app-form-book',
  templateUrl: './form-book.component.html',
  styleUrls: ['./form-book.component.css']
})
export class FormBookComponent implements OnInit {

  constructor(private db:IsbnDetailsService) { }

  ngOnInit() {
    this.db.test().subscribe(x => console.log(x));
  }

}
