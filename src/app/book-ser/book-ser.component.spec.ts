import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { BookSerComponent } from './book-ser.component';

describe('BookSerComponent', () => {
  let component: BookSerComponent;
  let fixture: ComponentFixture<BookSerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ BookSerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BookSerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
