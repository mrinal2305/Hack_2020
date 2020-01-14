import { Component, OnInit } from '@angular/core';
import { ActivatedRoute , Router} from '@angular/router';

@Component({
  selector: 'app-stu-info',
  templateUrl: './stu-info.component.html',
  styleUrls: ['./stu-info.component.css']
})
export class StuInfoComponent implements OnInit {

  constructor(public route : ActivatedRoute) {
    
   }

  ngOnInit() {
    // console.log(this.route.snapshot.queryParamMap.get('message'));  // GETTING VALUE
  }

}
