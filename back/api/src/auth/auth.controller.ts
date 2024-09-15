import { User } from './entities/user.entity';
import { LoginUserDto } from './dto/login-user.dto';
import { GetUser } from './decorators/get-user.decorator';
import { CreateUserDto } from './dto/create-user.dto';
import { AuthService } from './auth.service';
import { Auth } from './decorators/auth.decorator';
import { PasswordUserDto } from './dto/password-user.dto';
import {
  Controller,
  Post,
  Body,
  Patch,
  Delete,
  Put,
  Param,
  ParseIntPipe,
  Get,
} from '@nestjs/common';
import { UpdateUserDto } from './dto/update-user.dto';
import { PaginationCompleteDto } from 'src/common/dto/pagination.dto';
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('getTable')
  getTable(@Body() paginationDto: PaginationCompleteDto) {
    return this.authService.getTable(paginationDto);
  }

  @Post('get/:id')
  @Auth()
  get(@Param('id', ParseIntPipe) id: number) {
    return this.authService.get(id);
  }

  @Post('create')
  register(@Body() createUserDto: CreateUserDto) {
    return this.authService.create(createUserDto);
  }

  @Put('update')
  @Auth()
  update(@GetUser() user: User, @Body() updateUserDto: UpdateUserDto) {
    return this.authService.updated(user, updateUserDto);
  }

  @Delete('delete/:userTypeId')
  @Auth()
  softDeleteUsers(@Param('userTypeId', ParseIntPipe) userTypeId: number) {
    return this.authService.delete(userTypeId);
  }

  @Patch('update-password')
  @Auth()
  updatePassword(
    @GetUser() user: User,
    @Body() passwordUserDto: PasswordUserDto,
  ) {
    return this.authService.updatePassword(user, passwordUserDto);
  }

  @Post('loginWeb')
  login(@Body() loginUserDto: LoginUserDto) {
    return this.authService.loginWeb(loginUserDto);
  }

  @Post('loginApp')
  loginApp(@Body() loginUserDto: LoginUserDto) {
    return this.authService.loginApp(loginUserDto);
  }

  @Post('profile')
  @Auth() //Verifica el token del usuario
  profile(@GetUser() user: User) {
    return this.authService.profile(user);
  }

  @Get('getInspectorOptions')
  getInspectorOptions() {
    return this.authService.getInspectorOptions();
  }

  @Get('getInstalatorOptions')
  getInstalatorOptions() {
    return this.authService.getInstalatorOptions();
  }
}
