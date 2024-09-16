class CoverageLinesModel {
  int id;
  List<Line> line;
  String color;

  CoverageLinesModel({
    required this.id,
    required this.line,
    required this.color,
  });

  factory CoverageLinesModel.fromJson(Map<String, dynamic> json) =>
      CoverageLinesModel(
        id: json["id"],
        line: List<Line>.from(json["line"].map((x) => Line.fromJson(x))),
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "line": List<dynamic>.from(line.map((x) => x.toJson())),
        "color": color,
      };
}

class Line {
  double lat;
  double lng;

  Line({
    required this.lat,
    required this.lng,
  });

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
