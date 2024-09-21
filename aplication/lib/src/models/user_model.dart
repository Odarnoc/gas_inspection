import 'package:mikinder/constants/constants.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.paternalName,
    required this.maternalName,
    required this.phone,
    required this.cellphone,
    required this.address,
    required this.image,
    required this.roles,
    required this.token,
  });

  int id;
  String email;
  String firstName;
  String paternalName;
  String maternalName;
  String phone;
  String cellphone;
  String address;
  String image;
  List<String> roles;
  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        paternalName: json["paternalName"],
        maternalName: json["maternalName"],
        phone: json["phone"] ?? 's/n',
        cellphone: json["cellphone"] ?? 's/n',
        address: json["address"] ?? 'n/a',
        image: json["image"].toString().length <= 10
            ? kImageClientDefault
            : json["image"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        token: json["token"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "paternalName": paternalName,
        "maternalName": maternalName,
        "phone": phone,
        "cellphone": cellphone,
        "address": address,
        "image": image,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "token": token,
      };
}
