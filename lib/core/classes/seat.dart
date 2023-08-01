class Seat {
  Seat({
    required this.line,
    required this.letter,
    // required this.seatPart,
    // required this.isExitDoor,
    // required this.classType,
    // required this.isUsed,
    required this.isUsedDescription,
    // required this.seatProperty,
    // required this.mainIndex,
    // required this.isSelectable,
    this.price,
  });

  String line;
  String letter;

  // String seatPart;
  // bool isExitDoor;
  // String classType;
  // int isUsed;
  String isUsedDescription;

  // String seatProperty;
  // double mainIndex;
  // int isSelectable;
  int? price;

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        line: json["Line"],
        letter: json["Letter"],
        // seatPart: json["Part"],
        // isExitDoor: json["IsExitDoor"],
        // classType: json["ClassType"],
        // isUsed: json["IsUsed"],
        isUsedDescription: json["IsUsedDescription"],
        // seatProperty: json["SeatProperty"],
        // mainIndex: json["MainIndex"].toDouble(),
        // isSelectable: json["IsSelectable"],
        price: json["Price"] ?? json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "Line": line,
        "Letter": letter,
        // "Part": seatPart,
        // "IsExitDoor": isExitDoor,
        // "ClassType": classType,
        // "IsUsed": isUsed,
        "IsUsedDescription": isUsedDescription,
        // "SeatProperty": seatProperty,
        // "MainIndex": mainIndex,
        // "IsSelectable": isSelectable,
        "Price": price,
      };
}
