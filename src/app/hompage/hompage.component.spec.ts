import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { HompageComponent } from './hompage.component';

describe('HompageComponent', () => {
  let component: HompageComponent;
  let fixture: ComponentFixture<HompageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ HompageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HompageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
