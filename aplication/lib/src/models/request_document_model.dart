class RequestDocumentModel {
  int id;
  String documentUrl;

  RequestDocumentModel({
    required this.id,
    required this.documentUrl,
  });

  factory RequestDocumentModel.fromJson(Map<String, dynamic> json) =>
      RequestDocumentModel(
        id: json["id"],
        documentUrl: json["documentUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "documentUrl": documentUrl,
      };
}
