import { Injectable } from '@angular/core';
import { CanActivate } from '@angular/router';
import { AuthService } from './auth.service'; 
import { Observable } from 'rxjs';
import { Router ,ActivatedRouteSnapshot, RouterStateSnapshot} from '@angular/router';

 
@Injectable({
  providedIn: 'root'
})
export class AuthGuardService implements CanActivate {

  path: ActivatedRouteSnapshot[];
  route: ActivatedRouteSnapshot;

  constructor(private auth : AuthService,private router : Router) { }

  canActivate(route: ActivatedRouteSnapshot,state: RouterStateSnapshot ) :  Observable<boolean> | Promise<boolean> |boolean 
  {
    var id = localStorage.getItem('uid');
    if(id) return true;

    this.router.navigate(['/auth'],{queryParams : {returnUrl: state.url }}); // STEP 1: Send URL
    return false;   
  }

}