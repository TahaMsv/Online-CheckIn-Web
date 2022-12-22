import 'cabin.dart';

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
