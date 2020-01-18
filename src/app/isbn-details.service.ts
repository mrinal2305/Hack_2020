import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class IsbnDetailsService {

  constructor(public http: HttpClient) { }

  details(isbn){
    return this.http.get('http://nameless-fortress-08601.herokuapp.com/details/0253346568');
  }
  
}
