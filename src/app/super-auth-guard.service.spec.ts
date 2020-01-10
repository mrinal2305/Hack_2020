import { TestBed } from '@angular/core/testing';

import { SuperAuthGuardService } from './super-auth-guard.service';

describe('SuperAuthGuardService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: SuperAuthGuardService = TestBed.get(SuperAuthGuardService);
    expect(service).toBeTruthy();
  });
});
