class PassPortType {
  PassPortType({
    required this.id,
    required this.shortName,
    required this.name,
    required this.fullName,
  });

  int id;
  String shortName;
  String name;
  String fullName;

  factory PassPortType.fromJson(Map<String, dynamic> json) => PassPortType(
        id: json["ID"],
        shortName: json["ShortName"],
        name: json["name"],
        fullName: json["FullName"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ShortName": shortName,
        "name": name,
        "FullName": fullName,
      };

  factory PassPortType.example() => PassPortType(
        id: -1,
        shortName: "",
        name: "",
        fullName: "Passport Type",
      );
}
