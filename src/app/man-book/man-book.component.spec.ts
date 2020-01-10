import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ManBookComponent } from './man-book.component';

describe('ManBookComponent', () => {
  let component: ManBookComponent;
  let fixture: ComponentFixture<ManBookComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ManBookComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ManBookComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
