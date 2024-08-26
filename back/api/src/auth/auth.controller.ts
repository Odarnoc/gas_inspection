import { User } from './entities/user.entity';
import { LoginUserDto } from './dto/login-user.dto';
import { GetUser } from './decorators/get-user.decorator';
import { CreateUserDto } from './dto/create-user.dto';
import { AuthService } from './auth.service';
import { Auth } from './decorators/auth.decorator';
import { PasswordUserDto } from './dto/password-user.dto';
import { Controller, Post, Body, Patch } from '@nestjs/common';
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  register(@Body() createUserDto: CreateUserDto) {
    return this.authService.register(createUserDto);
  }

  @Patch('update-password')
  @Auth()
  updatePassword(
    @GetUser() user: User,
    @Body() passwordUserDto: PasswordUserDto,
  ) {
    return this.authService.updatePassword(user, passwordUserDto);
  }

  @Post('login')
  login(@Body() loginUserDto: LoginUserDto) {
    return this.authService.login(loginUserDto);
  }

  @Post('profile')
  @Auth() //Verifica el token del usuario
  profile(@GetUser() user: User) {
    return this.authService.profile(user);
  }
}
