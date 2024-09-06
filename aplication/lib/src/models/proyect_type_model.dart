class ProyectTypeModel {
  int id;
  String name;
  String details;

  ProyectTypeModel({
    required this.id,
    required this.name,
    required this.details,
  });

  factory ProyectTypeModel.fromJson(Map<String, dynamic> json) =>
      ProyectTypeModel(
        id: json["id"],
        name: json["name"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "details": details,
      };
}
