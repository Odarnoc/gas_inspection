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
  String isometric;
  String floorPlan;
  String materials;
  bool minimumVolume;
  bool airSupply;
  bool airOutlet;
  bool rapidAeration;
  bool pressureCheck;
  bool valvuleCheck;
  bool leakCheck;
  bool ventilation;
  bool areaCleaning;
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
    required this.isometric,
    required this.floorPlan,
    required this.materials,
    required this.minimumVolume,
    required this.airSupply,
    required this.airOutlet,
    required this.rapidAeration,
    required this.pressureCheck,
    required this.valvuleCheck,
    required this.leakCheck,
    required this.ventilation,
    required this.areaCleaning,
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
        isometric: json["isometric"],
        floorPlan: json["floorPlan"],
        materials: json["materials"],
        minimumVolume: json["minimumVolume"],
        airSupply: json["airSupply"],
        airOutlet: json["airOutlet"],
        rapidAeration: json["rapidAeration"],
        pressureCheck: json["pressureCheck"],
        valvuleCheck: json["valvuleCheck"],
        leakCheck: json["leakCheck"],
        ventilation: json["ventilation"],
        areaCleaning: json["areaCleaning"],
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
        "isometric": isometric,
        "floorPlan": floorPlan,
        "materials": materials,
        "minimumVolume": minimumVolume,
        "airSupply": airSupply,
        "airOutlet": airOutlet,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "limitDate":
            "${limitDate.year.toString().padLeft(4, '0')}-${limitDate.month.toString().padLeft(2, '0')}-${limitDate.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt.toIso8601String(),
        "proyectType": proyectType.toJson(),
      };
}
