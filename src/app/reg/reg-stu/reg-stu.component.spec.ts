import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RegStuComponent } from './reg-stu.component';

describe('RegStuComponent', () => {
  let component: RegStuComponent;
  let fixture: ComponentFixture<RegStuComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RegStuComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RegStuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
