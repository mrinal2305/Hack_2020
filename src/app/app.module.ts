import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AngularFireModule } from '@angular/fire';
import { AngularFirestoreModule } from '@angular/fire/firestore';
import { AngularFireAuthModule } from '@angular/fire/auth';
import { AngularFireStorageModule } from '@angular/fire/storage';
import { environment } from '../environments/environment';
import { AppRoutingModule ,routingComponents} from './app-routing.module';
import { AppComponent } from './app.component';
import { TitleBarComponent } from './title-bar/title-bar.component';
import { AuthService } from './auth.service';
import { AuthGuardService } from './auth-guard.service';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AdminAuthGuardService } from './admin-auth-guard.service';
import { SuperAuthGuardService } from './super-auth-guard.service';
import { HamburgerComponent } from './hamburger/hamburger.component';
import { DropzoneDirective } from './dropzone.directive';
import { FileSizePipe } from './file-size.pipe';
import { UploadComponent } from './upload/upload.component';
import { routingModule } from './material.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import { FormBookComponent } from './form-book/form-book.component';
import { BookService } from './book.service';
import { IsbnDetailsService } from './isbn-details.service';
import { HttpClientModule } from '@angular/common/http';
 // import { CustomFormsModule } from 'ng2-validation';

@NgModule({
  declarations: [ // It happen for components
    AppComponent,
    TitleBarComponent,
    routingComponents,
    HamburgerComponent,
    DropzoneDirective,
    FileSizePipe,
    UploadComponent,
    FormBookComponent
  ],
  imports: [    // It happen for modules
    AngularFireModule.initializeApp(environment.firebase),
    AngularFirestoreModule, // imports firebase/firestore, only needed for database features
    AngularFireAuthModule, // imports firebase/auth, only needed for auth features
    AngularFireStorageModule,
    BrowserModule,
    HttpClientModule,
    FormsModule,
    routingModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
    AppRoutingModule
  ],
  providers: [AuthService,AuthGuardService,AdminAuthGuardService,SuperAuthGuardService,BookService,IsbnDetailsService],       // It happens for services
  bootstrap: [AppComponent]
})
export class AppModule { }