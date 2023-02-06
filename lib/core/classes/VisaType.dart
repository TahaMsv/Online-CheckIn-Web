class VisaType {
  VisaType({
    required this.id,
    required this.shortName,
    required this.name,
    required this.fullName,
  });

  int id;
  String shortName;
  String name;
  String fullName;

  factory VisaType.fromJson(Map<String, dynamic> json) => VisaType(
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

  factory VisaType.example() => VisaType(
        id: -1,
        shortName: "",
        name: "",
        fullName: "Type",
      );
}
