import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RegMemComponent } from './reg-mem.component';

describe('RegMemComponent', () => {
  let component: RegMemComponent;
  let fixture: ComponentFixture<RegMemComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RegMemComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RegMemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
