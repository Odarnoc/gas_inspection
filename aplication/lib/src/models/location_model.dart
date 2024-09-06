class LocationModel {
  double x;
  double y;

  LocationModel({
    required this.x,
    required this.y,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
