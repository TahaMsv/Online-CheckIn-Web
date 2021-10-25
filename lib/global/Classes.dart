// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    required this.aircraft,
    required this.seatMap,
    required this.fromCity,
    required this.toCity,
    required this.fromCityName,
    required this.toCityName,
    required this.fromTime,
    required this.toTime,
    required this.attendanceTime,
    required this.flightDateShamsi,
    required this.flightDate,
    required this.flightDayShamsi,
    required this.terminal,
    required this.weightAdl,
    required this.weightChd,
    required this.weightInf,
    required this.alNameFa,
    required this.al,
    required this.dayOfWeek,
    required this.flnb,
    required this.aircraftId,
    required this.alName,
    required this.aircraftShowName,
    required this.boardingTime,
    required this.id,
    required this.seats,
  });

  String aircraft;
  String seatMap;
  String fromCity;
  String toCity;
  String fromCityName;
  String toCityName;
  String fromTime;
  String toTime;
  String attendanceTime;
  String flightDateShamsi;
  DateTime flightDate;
  String flightDayShamsi;
  int terminal;
  int weightAdl;
  int weightChd;
  int weightInf;
  String alNameFa;
  String al;
  String dayOfWeek;
  String flnb;
  int aircraftId;
  String alName;
  String aircraftShowName;
  String boardingTime;
  int id;
  List<Seat> seats;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    aircraft: json["Aircraft"],
    seatMap: json["SeatMap"],
    fromCity: json["From_City"],
    toCity: json["To_City"],
    fromCityName: json["From_CityName"],
    toCityName: json["To_CityName"],
    fromTime: json["From_Time"],
    toTime: json["To_Time"],
    attendanceTime: json["AttendanceTime"],
    flightDateShamsi: json["FlightDateShamsi"],
    flightDate: DateTime.parse(json["FlightDate"]),
    flightDayShamsi: json["FlightDayShamsi"],
    terminal: json["Terminal"],
    weightAdl: json["Weight_ADL"],
    weightChd: json["Weight_CHD"],
    weightInf: json["Weight_INF"],
    alNameFa: json["AL_Name_Fa"],
    al: json["AL"],
    dayOfWeek: json["DayOfWeek"],
    flnb: json["FLNB"],
    aircraftId: json["AircraftID"],
    alName: json["AL_Name"],
    aircraftShowName: json["AircraftShowName"],
    boardingTime: json["BoardingTime"],
    id: json["ID"],
    seats: List<Seat>.from(json["Seats"].map((x) => Seat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Aircraft": aircraft,
    "SeatMap": seatMap,
    "From_City": fromCity,
    "To_City": toCity,
    "From_CityName": fromCityName,
    "To_CityName": toCityName,
    "From_Time": fromTime,
    "To_Time": toTime,
    "AttendanceTime": attendanceTime,
    "FlightDateShamsi": flightDateShamsi,
    "FlightDate": "${flightDate.year.toString().padLeft(4, '0')}-${flightDate.month.toString().padLeft(2, '0')}-${flightDate.day.toString().padLeft(2, '0')}",
    "FlightDayShamsi": flightDayShamsi,
    "Terminal": terminal,
    "Weight_ADL": weightAdl,
    "Weight_CHD": weightChd,
    "Weight_INF": weightInf,
    "AL_Name_Fa": alNameFa,
    "AL": al,
    "DayOfWeek": dayOfWeek,
    "FLNB": flnb,
    "AircraftID": aircraftId,
    "AL_Name": alName,
    "AircraftShowName": aircraftShowName,
    "BoardingTime": boardingTime,
    "ID": id,
    "Seats": List<dynamic>.from(seats.map((x) => x.toJson())),
  };
}

class Seat {
  Seat({
    required this.line,
    required this.letter,
    required this.seatPart,
    required this.isExitDoor,
    required this.classType,
    required this.isUsed,
    required this.isUsedDescription,
    required this.seatProperty,
    required this.cabinIndex,
    required this.isSelectable,
    required this.flightScheduleId,
    required this.passengers,
  });

  String line;
  ClassType letter;
  ClassType seatPart;
  bool isExitDoor;
  ClassType classType;
  int isUsed;
  IsUsedDescription isUsedDescription;
  SeatProperty seatProperty;
  int cabinIndex;
  int isSelectable;
  int flightScheduleId;
  List<Passenger> passengers;

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    line: json["Line"],
    letter: classTypeValues.map[json["Letter"]]!,
    seatPart: classTypeValues.map[json["Part"]]!,
    isExitDoor: json["IsExitDoor"],
    classType: classTypeValues.map[json["ClassType"]]!,
    isUsed: json["IsUsed"],
    isUsedDescription: isUsedDescriptionValues.map[json["IsUsedDescription"]]!,
    seatProperty: seatPropertyValues.map[json["SeatProperty"]]!,
    cabinIndex: json["CabinIndex"],
    isSelectable: json["IsSelectable"],
    flightScheduleId: json["FlightScheduleID"],
    passengers: List<Passenger>.from(json["Passengers"].map((x) => Passenger.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Line": line,
    "Letter": classTypeValues.reverse[letter],
    "Part": classTypeValues.reverse[seatPart],
    "IsExitDoor": isExitDoor,
    "ClassType": classTypeValues.reverse[classType],
    "IsUsed": isUsed,
    "IsUsedDescription": isUsedDescriptionValues.reverse[isUsedDescription],
    "SeatProperty": seatPropertyValues.reverse[seatProperty],
    "CabinIndex": cabinIndex,
    "IsSelectable": isSelectable,
    "FlightScheduleID": flightScheduleId,
    "Passengers": List<dynamic>.from(passengers.map((x) => x.toJson())),
  };
}

enum ClassType { B, A, E, F, C, D }

final classTypeValues = EnumValues({
  "A": ClassType.A,
  "B": ClassType.B,
  "C": ClassType.C,
  "D": ClassType.D,
  "E": ClassType.E,
  "F": ClassType.F
});

enum IsUsedDescription { OPEN }

final isUsedDescriptionValues = EnumValues({
  "Open": IsUsedDescription.OPEN
});

class Passenger {
  Passenger({
    required this.id,
    required this.reference,
    required this.name,
    required this.nationalId,
    required this.passengerType,
    required this.classType,
    required this.firstName,
    required this.lastName,
    required this.passengerClass,
    required this.title,
    required this.docsBirthDate,
    required this.docsTitle,
    required this.flightScheduleId,
  });

  int id;
  Reference reference;
  Name name;
  NationalId nationalId;
  PassengerType passengerType;
  ClassType classType;
  FirstName firstName;
  LastName lastName;
  Class passengerClass;
  Title title;
  DateTime docsBirthDate;
  ClassType docsTitle;
  int flightScheduleId;

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    id: json["ID"],
    reference: referenceValues.map[json["Reference"]]!,
    name: nameValues.map[json["Name"]]!,
    nationalId: nationalIdValues.map[json["NationalID"]]!,
    passengerType: passengerTypeValues.map[json["PassengerType"]]!,
    classType: classTypeValues.map[json["ClassType"]]!,
    firstName: firstNameValues.map[json["FirstName"]]!,
    lastName: lastNameValues.map[json["LastName"]]!,
    passengerClass: classValues.map[json["Class"]]!,
    title: titleValues.map[json["Title"]]!,
    docsBirthDate: DateTime.parse(json["DocsBirthDate"]),
    docsTitle: classTypeValues.map[json["DocsTitle"]]!,
    flightScheduleId: json["FlightScheduleID"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Reference": referenceValues.reverse[reference],
    "Name": nameValues.reverse[name],
    "NationalID": nationalIdValues.reverse[nationalId],
    "PassengerType": passengerTypeValues.reverse[passengerType],
    "ClassType": classTypeValues.reverse[classType],
    "FirstName": firstNameValues.reverse[firstName],
    "LastName": lastNameValues.reverse[lastName],
    "Class": classValues.reverse[passengerClass],
    "Title": titleValues.reverse[title],
    "DocsBirthDate": "${docsBirthDate.year.toString().padLeft(4, '0')}-${docsBirthDate.month.toString().padLeft(2, '0')}-${docsBirthDate.day.toString().padLeft(2, '0')}",
    "DocsTitle": classTypeValues.reverse[docsTitle],
    "FlightScheduleID": flightScheduleId,
  };
}

enum FirstName { MIA }

final firstNameValues = EnumValues({
  "MIA": FirstName.MIA
});

enum LastName { YOUNG }

final lastNameValues = EnumValues({
  "YOUNG": LastName.YOUNG
});

enum Name { MIA_YOUNG }

final nameValues = EnumValues({
  "MIA YOUNG": Name.MIA_YOUNG
});

enum NationalId { P521466301 }

final nationalIdValues = EnumValues({
  "P521466301": NationalId.P521466301
});

enum Class { Y }

final classValues = EnumValues({
  "Y": Class.Y
});

enum PassengerType { ADL }

final passengerTypeValues = EnumValues({
  "ADL": PassengerType.ADL
});

enum Reference { TBVD }

final referenceValues = EnumValues({
  "TBVD": Reference.TBVD
});

enum Title { MRS }

final titleValues = EnumValues({
  "MRS": Title.MRS
});

enum SeatProperty { SEAT }

final seatPropertyValues = EnumValues({
  "Seat": SeatProperty.SEAT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues( this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
