import 'package:mikinder/src/models/location_model.dart';
import 'package:mikinder/src/models/proyect_type_model.dart';

class RequestPetitionModel {
  int id;
  String firstName;
  String paternalName;
  String maternalName;
  String phone;
  String cellphone;
  String zone;
  String avenue;
  String street;
  String door;
  String references;
  int status;
  LocationModel location;
  DateTime startDate;
  DateTime limitDate;
  DateTime createdAt;
  ProyectTypeModel proyectType;

  RequestPetitionModel({
    required this.id,
    required this.firstName,
    required this.paternalName,
    required this.maternalName,
    required this.phone,
    required this.cellphone,
    required this.zone,
    required this.avenue,
    required this.street,
    required this.door,
    required this.references,
    required this.status,
    required this.location,
    required this.startDate,
    required this.limitDate,
    required this.createdAt,
    required this.proyectType,
  });

  factory RequestPetitionModel.fromJson(Map<String, dynamic> json) =>
      RequestPetitionModel(
        id: json["id"],
        firstName: json["firstName"],
        paternalName: json["paternalName"],
        maternalName: json["maternalName"],
        phone: json["phone"],
        cellphone: json["cellphone"],
        zone: json["zone"],
        avenue: json["avenue"],
        street: json["street"],
        door: json["door"],
        references: json["references"],
        status: json["status"],
        location: LocationModel.fromJson(json["location"]),
        startDate: DateTime.parse(json["startDate"]),
        limitDate: DateTime.parse(json["limitDate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        proyectType: ProyectTypeModel.fromJson(json["proyectType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "paternalName": paternalName,
        "maternalName": maternalName,
        "phone": phone,
        "cellphone": cellphone,
        "zone": zone,
        "avenue": avenue,
        "street": street,
        "door": door,
        "references": references,
        "status": status,
        "location": location.toJson(),
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "limitDate":
            "${limitDate.year.toString().padLeft(4, '0')}-${limitDate.month.toString().padLeft(2, '0')}-${limitDate.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt.toIso8601String(),
        "proyectType": proyectType.toJson(),
      };
}
