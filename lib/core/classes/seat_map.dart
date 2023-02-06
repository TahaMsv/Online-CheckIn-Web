

class SeatMap {
  SeatMap({
    required this.cabins,
  });

  List<Cabin> cabins;

  factory SeatMap.fromJson(Map<String, dynamic> json) => SeatMap(
    cabins: List<Cabin>.from(json["Cabins"].map((x) => Cabin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Cabins": List<dynamic>.from(cabins.map((x) => x.toJson())),
  };
}

class Cabin {
  Cabin({
    required this.cabinClass,
    required this.linesCount,
    required this.cabinTitle,
    required this.lines,
    // required this.zones,
    // required this.sumZones,
  });

  String cabinClass;
  int linesCount;
  String cabinTitle;
  List<Line> lines;

  // List<dynamic> zones;
  // int sumZones;

  factory Cabin.fromJson(Map<String, dynamic> json) => Cabin(
    cabinClass: json["CabinClass"],
    linesCount: json["LinesCount"],
    cabinTitle: json["CabinTitle"],
    lines: List<Line>.from(json["Lines"].map((x) => Line.fromJson(x))),
    // zones: List<dynamic>.from(json["Zones"].map((x) => x)),
    // sumZones: json["SumZones"],
  );

  Map<String, dynamic> toJson() => {
    "CabinClass": cabinClass,
    "LinesCount": linesCount,
    "CabinTitle": cabinTitle,
    "Lines": List<dynamic>.from(lines.map((x) => x.toJson())),
    // "Zones": List<dynamic>.from(zones.map((x) => x)),
    // "SumZones": sumZones,
  };
}


class Line {
  Line({
    required this.type,
    // required this.arm,
    // required this.index,
    // required this.isIndex,
    // required this.zone,
    // required this.seatsCount,
    // required this.line,
    required this.cells,
  });

  String type;

  // dynamic arm;
  // dynamic index;
  // bool isIndex;
  // dynamic zone;
  // int seatsCount;
  // dynamic line;
  List<Cell> cells;

  factory Line.fromJson(Map<String, dynamic> json) => Line(
    type: json["Type"],
    // arm: json["Arm"],
    // index: json["Index"],
    // isIndex: json["IsIndex"],
    // zone: json["Zone"],
    // seatsCount: json["SeatsCount"],
    // line: json["Line"],
    cells: List<Cell>.from(json["Cells"].map((x) => Cell.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Type": type,
    // "Arm": arm,
    // "Index": index,
    // "IsIndex": isIndex,
    // "Zone": zone,
    // "SeatsCount": seatsCount,
    // "Line": line,
    "Cells": List<dynamic>.from(cells.map((x) => x.toJson())),
  };
}


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



enum RunningMode { web, tablet }

extension FlavorExtension on RunningMode {
  String get name {
    switch (this) {
      case RunningMode.web:
        return "web";
      case RunningMode.tablet:
        return "tablet";
      default:
        return "web";
    }
  }
}

enum CabinClass { business, firstClass, economy }

extension CabinClassExtension on CabinClass {
  String get name {
    switch (this) {
      case CabinClass.business:
        return "Business";
      case CabinClass.firstClass:
        return "First Class";
      case CabinClass.economy:
        return "Economy";
      default:
        return "Economy";
    }
  }
}

enum SeatType { block, temporaryBlock, checkedIn, wBTemporaryBlock, click, open, checkInOtherFlight }

extension SeatTypeExtension on SeatType {
  String get name {
    switch (this) {
      case SeatType.block:
        return "Block";
      case SeatType.temporaryBlock:
        return "TemporaryBlock";
      case SeatType.checkedIn:
        return "Checked-in";
      case SeatType.wBTemporaryBlock:
        return "WBTemporaryBlock";
      case SeatType.click:
        return "Click";
      case SeatType.open:
        return "Open";
      case SeatType.open:
        return "Check in other Flight";
      default:
        return "Checked-in";
    }
  }
}

enum CellType { seat, outEquipmentExit, outEquipmentWing, verticalCode, aile, checkInOtherFlight }

extension CellTypeExtension on CellType {
  String get name {
    switch (this) {
      case CellType.seat:
        return "Seat";
      case CellType.outEquipmentExit:
        return "OutEquipmentExit";
      case CellType.outEquipmentWing:
        return "OutEquipmentWing";
      case CellType.verticalCode:
        return "VerticalCode";
      case CellType.aile:
        return "Aile";

      default:
        return "Seat";
    }
  }
}

