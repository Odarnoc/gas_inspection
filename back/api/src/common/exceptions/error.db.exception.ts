import {
  BadRequestException,
  InternalServerErrorException,
  Logger,
} from '@nestjs/common';

export default function handleDbExceptions(error: any, logger: Logger): never {
  if (error instanceof BadRequestException) {
    throw error;
  }
  logger.error(error);
  if (error.code === '23505' || error.code === '23503')
    throw new BadRequestException(error.detail);

  if (error.code === '23502')
    throw new BadRequestException('Relationships between entities, invalid');

  throw new InternalServerErrorException('InternalServerError');
}
