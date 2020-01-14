import { Injectable } from '@angular/core';
import { CanActivate } from '@angular/router';
import { AuthService } from './auth.service'; 
import { Observable } from 'rxjs';
import { Router ,ActivatedRouteSnapshot, RouterStateSnapshot} from '@angular/router';

// WORKING

@Injectable({
  providedIn: 'root'
})
export class SuperAuthGuardService {

  constructor(private auth : AuthService,private router : Router) { }

  canActivate(route: ActivatedRouteSnapshot,state: RouterStateSnapshot ) :  Observable<boolean> | Promise<boolean> |boolean 
  {
    var id = localStorage.getItem('isSuper');
    console.log(id);
    if(id != undefined) return true;
    
    this.router.navigate(['/'],{queryParams : {error: "Not allowed to get access" }}); // STEP 1: Send URL
    return false;   
  }
}
