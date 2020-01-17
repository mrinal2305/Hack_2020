import { Component, OnInit } from '@angular/core';
import { AngularFireStorage } from 'angularfire2/storage';
import { AngularFireStorageReference, AngularFireUploadTask } from 'angularfire2/storage';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-upload',
  templateUrl: './upload.component.html',
  styleUrls: ['./upload.component.css']
})
export class UploadComponent implements OnInit {

  ref: AngularFireStorageReference;
  task: AngularFireUploadTask;
  uploadProgress$: Observable<number>;
  downloadURL: Observable<string>;
  showBar :boolean = true;
 
  constructor(private afStorage: AngularFireStorage) { }

  upload(event) {
    const id = Math.random().toString(36).substring(2);
    this.ref = this.afStorage.ref(id);
    this.task = this.ref.put(event.target.files[0]);
    this.uploadProgress$ = this.task.percentageChanges();
    this.uploadProgress$.subscribe(val => {
      console.log(val);
      if(val == 100 ) this.showBar = false;
    });

    var prom = new Promise((resolve,reject)=>{
      this.task.then(snapshot => {
        snapshot.ref.getDownloadURL().then(val =>{
          // console.log(val);// Getting IMAGE URL
          resolve(val);
        }); 
      })
    })

    prom.then(val => console.log(val)); // SUCCESS GETTING BOOK
   
  }

  ngOnInit() {
  }

}
