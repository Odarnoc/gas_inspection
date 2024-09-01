class CodeError {
  static const int none = 0;
  static const int unknown = 100;
  static const int emailUnique = 101;
  static const int phoneUnique = 102;
  static const int nameUnique = 103;

  static const int unauthorized = 401;
  static const int accountnotexist = 402;

  static const int notBalance = 501;
  static const int insufficientBalance = 502;
  static const int orderFulfilled = 503;
  static const int unVerifiedUser = 504;
  static const int unVerifiedVehicle = 505;
  static const int emptyVehicle = 506;
  static const int unverifiedEmail = 507;
  static const int calculateRouteError = 513;
  static const int wrongLoginCode = 522;

  static const int deliverymanNotFound = 4001;

  //The deliveryman role cannot have the role of manager.
  static const int deliverymanCannotBeManager = 4002;

  //The manager role cannot have the role of deliveryman.
  static const int managerCannotBeDeliveryman = 4002;

  static const int wrongGroupCode = 4010;

  static const int uncheckPolicies = 4011;
}
