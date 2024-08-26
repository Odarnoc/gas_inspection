import { AuthGuard } from '@nestjs/passport';
import { applyDecorators, UseGuards } from '@nestjs/common';
import { UserVerifyGuard } from '../guards/user-verify.guard';

export function Verify() {
  return applyDecorators(UseGuards(AuthGuard(), UserVerifyGuard));
}
