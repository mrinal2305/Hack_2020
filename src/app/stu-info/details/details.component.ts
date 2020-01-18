import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-details',
  templateUrl: './details.component.html',
  styleUrls: ['./details.component.css']
})
export class DetailsComponent implements OnInit {
  id : any;
  constructor(public route : ActivatedRoute) { }
  
  ngOnInit() {

   this.id = this.route.snapshot.queryParamMap.get('id'); // Getting URL send by previous browser
   console.log(this.id);
   
  }

}
