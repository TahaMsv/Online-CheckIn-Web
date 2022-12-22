import 'cell.dart';

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
