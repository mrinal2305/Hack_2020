import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AngularFireModule } from '@angular/fire';
import { AngularFirestoreModule } from '@angular/fire/firestore';
import { AngularFireAuthModule } from '@angular/fire/auth';
import { environment } from '../environments/environment';
import { AppRoutingModule ,routingComponents} from './app-routing.module';
import { AppComponent } from './app.component';
import { TitleBarComponent } from './title-bar/title-bar.component';
import { AuthService } from './auth.service';
import { AuthGuardService } from './auth-guard.service';
import { FormsModule } from  '@angular/forms';
import { AuthComponent } from './auth/auth.component';

// import { CustomFormsModule } from 'ng2-validation';

@NgModule({
  declarations: [ // It happen for components
    AppComponent,
    TitleBarComponent,
    routingComponents
  ],
  imports: [    // It happen for modules
    AngularFireModule.initializeApp(environment.firebase),
    AngularFirestoreModule, // imports firebase/firestore, only needed for database features
    AngularFireAuthModule, // imports firebase/auth, only needed for auth features
    BrowserModule,
    FormsModule,
    AppRoutingModule
  ],
  providers: [AuthService,AuthGuardService],       // It happens for services
  bootstrap: [AppComponent]
})
export class AppModule { }