import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class IsbnDetailsService {

  constructor(public http: HttpClient) { }
  
  peaceful_title(title){
    return this.http.get('https://peaceful-river-61209.herokuapp.com/title_author/'+title);
  }
  
  peaceful_isbn(isbn){
    return this.http.get('https://peaceful-river-61209.herokuapp.com/isbn/'+isbn);
  }

  nameless_details(isbn){
    return this.http.get('https://nameless-fortress-08601.herokuapp.com/details/'+isbn);
  }

  nameless_ddc(title){
    return this.http.get('https://nameless-fortress-08601.herokuapp.com/ddc_lcc/'+title);
  }

  nameless_category(title){
    return this.http.get('https://nameless-fortress-08601.herokuapp.com/category/'+title)
  }

  intense_subCategory(text){
    return this.http.get('http://intense-thicket-08147.herokuapp.com/subCategory?text='+text);
  }

  intense_concept(text){
    return this.http.get('http://intense-thicket-08147.herokuapp.com/concept?text='+text);
  }
  
}
