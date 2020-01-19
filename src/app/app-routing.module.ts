import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ManBookComponent } from './man-book/man-book.component';
import { BookSerComponent } from './book-ser/book-ser.component';
import { RegComponent } from './reg/reg.component';
import { StuInfoComponent } from './stu-info/stu-info.component';
import { AuthComponent } from './auth/auth.component';
import { HompageComponent } from './hompage/hompage.component';
import { FormBookComponent } from './form-book/form-book.component';
import { AuthGuardService } from './auth-guard.service';
import {  AdminAuthGuardService } from './admin-auth-guard.service';
import { SuperAuthGuardService } from './super-auth-guard.service';
import { UploadComponent } from './upload/upload.component';;
import { from } from 'rxjs';
import { RegMemComponent } from './reg/reg-mem/reg-mem.component';
import { RegStuComponent } from './reg/reg-stu/reg-stu.component';
import { DetailsComponent } from './stu-info/details/details.component';
import { BookDetailsComponent } from './book-ser/book-details/book-details.component';
import { AddBookComponent } from './add-book/add-book.component';
import {FullDetailComponent } from './add-book/full-detail/full-detail.component';

const routes: Routes = [
  {path :"",           component : HompageComponent},
  {path :"auth",       component : AuthComponent,},
  {path :"stu_info",   component : StuInfoComponent},//canActivate :[AuthGuardService,SuperAuthGuardService]},
  {path :"man_book",   component : ManBookComponent},//canActivate :[AuthGuardService,AdminAuthGuardService]},
  {path :"book_ser",   component : BookSerComponent},//canActivate :[AuthGuardService]},
  {path :"regs",       component : RegComponent},//canActivate :[AuthGuardService]},  
  {path :"upload" ,   component : UploadComponent},
  {path : "man_book/edit" ,component : FormBookComponent}, 
  {path : "man_book/edit/:id" ,component : FormBookComponent},
  {path : "regs/mem" ,component:RegMemComponent},
  {path : "man_book/add" ,component:AddBookComponent},
  {path : "man_book/:id" ,component:AddBookComponent},
  {path : "man_book/add/details",component:FullDetailComponent},
  {path : "regs/stu" , component:RegStuComponent},
  {path : "stu_info/details",component:DetailsComponent},
  {path : "stu_info/details/:id",component:DetailsComponent},
  {path : "book_ser/details" ,component:BookDetailsComponent},
  {path : "book_ser/details/:id" ,component:BookDetailsComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes,{useHash : true})],// unHash cause error
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
  RegComponent,
  FormBookComponent
];