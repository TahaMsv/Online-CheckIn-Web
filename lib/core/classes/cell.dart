class Cell {
  Cell({
    required this.type,
    required this.value,
    required this.letter,
    required this.line,
    required this.code,
    // required this.attribiutes,
    // required this.cellStatusType,
    // required this.cellStatusTypeText,
    // required this.flightPassengerId,
    // required this.genderType,
    // required this.hasInfant,
    // required this.classType,
  });

  String type;
  String? value;
  String? letter;
  String? line;
  String? code;

  // dynamic attribiutes;
  // String cellStatusType;
  // String cellStatusTypeText;
  // int flightPassengerId;
  // int genderType;
  // int hasInfant;
  // dynamic classType;

  factory Cell.fromJson(Map<String, dynamic> json) => Cell(
    type: json["Type"],
    value: json["Value"] == null ? null : json["Value"],
    letter: json["Letter"] == null ? null : json["Letter"],
    line: json["Line"] == null ? null : json["Line"],
    code: json["Code"] == null ? null : json["Code"],
    // attribiutes: json["Attribiutes"],
    // cellStatusType: json["CellStatusType"],
    // cellStatusTypeText: json["CellStatusTypeText"],
    // flightPassengerId: json["FlightPassengerId"],
    // genderType: json["GenderType"],
    // hasInfant: json["HasInfant"],
    // classType: json["ClassType"],
  );

  Map<String, dynamic> toJson() => {
    "Type": type,
    "Value": value == null ? null : value,
    "Letter": letter == null ? null : letter,
    "Line": line == null ? null : line,
    "Code": code,
    // "Attribiutes": attribiutes,
    // "CellStatusType":  cellStatusType,
    // "CellStatusTypeText":  cellStatusTypeText,
    // "FlightPassengerId": flightPassengerId,
    // "GenderType": genderType,
    // "HasInfant": hasInfant,
    // "ClassType": classType,
  };
}
