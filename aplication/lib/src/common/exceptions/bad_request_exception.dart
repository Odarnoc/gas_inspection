class BadRequestException implements Exception {
  String cause;
  BadRequestException(this.cause);
}
