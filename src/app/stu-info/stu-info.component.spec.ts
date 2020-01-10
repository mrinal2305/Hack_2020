import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StuInfoComponent } from './stu-info.component';

describe('StuInfoComponent', () => {
  let component: StuInfoComponent;
  let fixture: ComponentFixture<StuInfoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StuInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StuInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
