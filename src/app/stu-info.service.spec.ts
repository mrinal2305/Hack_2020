import { TestBed } from '@angular/core/testing';

import { StuInfoService } from './stu-info.service';

describe('StuInfoService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: StuInfoService = TestBed.get(StuInfoService);
    expect(service).toBeTruthy();
  });
});
