import { TestBed } from '@angular/core/testing';

import { IsbnDetailsService } from './isbn-details.service';

describe('IsbnDetailsService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: IsbnDetailsService = TestBed.get(IsbnDetailsService);
    expect(service).toBeTruthy();
  });
});
