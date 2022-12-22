

import 'line.dart';

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
