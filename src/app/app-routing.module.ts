import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ManBookComponent } from './man-book/man-book.component';
import { BookSerComponent } from './book-ser/book-ser.component';
import { RegComponent } from './reg/reg.component';
import { StuInfoComponent } from './stu-info/stu-info.component';
import { AuthComponent } from './auth/auth.component';
import { HompageComponent } from './hompage/hompage.component';
import { AuthGuardService } from './auth-guard.service';

const routes: Routes = [
  {path :"",   component : HompageComponent},
  {path :"auth",   component : AuthComponent,},
  {path :"stu_info",   component : StuInfoComponent ,canActivate :[AuthGuardService]},
  {path :"man_book",   component : ManBookComponent,canActivate :[AuthGuardService]},
  {path :"book_ser",   component : BookSerComponent,canActivate :[AuthGuardService]},
  {path :"regs",   component : RegComponent,canActivate :[AuthGuardService]},  
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

export const routingComponents =
 [ 
  HompageComponent,
  AuthComponent,
  StuInfoComponent,
  ManBookComponent,
  BookSerComponent,
  RegComponent
];