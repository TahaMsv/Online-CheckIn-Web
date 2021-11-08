// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Traveller {
  late String lastName;
  late String ticketNumber;

  Traveller({required this.lastName, required this.ticketNumber});

}

List<Welcome> welcomeFromJson(String str) {
  return List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));
}

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

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
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
  }

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

  String? line;
  String? letter;
  String? seatPart;
  bool? isExitDoor;
  String? classType;
  int? isUsed;
  String isUsedDescription;
  String? seatProperty;
  int? cabinIndex;
  int? isSelectable;
  int? flightScheduleId;
  List<Passenger> passengers;

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        line: json["Line"],
        letter: json["Letter"]!,
        seatPart: json["Part"]!,
        isExitDoor: json["IsExitDoor"],
        classType: json["ClassType"]!,
        isUsed: json["IsUsed"],
        isUsedDescription: json["IsUsedDescription"]!,
        seatProperty: json["SeatProperty"]!,
        cabinIndex: json["CabinIndex"],
        isSelectable: json["IsSelectable"],
        flightScheduleId: json["FlightScheduleID"],
        passengers: List<Passenger>.from(json["Passengers"].map((x) => Passenger.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Line": line,
        "Letter": letter,
        "Part": seatPart,
        "IsExitDoor": isExitDoor,
        "ClassType": classType,
        "IsUsed": isUsed,
        "IsUsedDescription": isUsedDescription,
        "SeatProperty": seatProperty,
        "CabinIndex": cabinIndex,
        "IsSelectable": isSelectable,
        "FlightScheduleID": flightScheduleId,
        "Passengers": List<dynamic>.from(passengers.map((x) => x.toJson())),
      };
}
//
// enum ClassType { B, A, E, F, C, D }
//
// final classTypeValues = EnumValues({"A": ClassType.A, "B": ClassType.B, "C": ClassType.C, "D": ClassType.D, "E": ClassType.E, "F": ClassType.F});
//

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
  String reference;
  String name;
  String nationalId;
  String passengerType;
  String classType;
  String firstName;
  String lastName;
  String passengerClass;
  String title;
  DateTime docsBirthDate;
  String docsTitle;
  int flightScheduleId;

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        id: json["ID"],
        reference: json["Reference"]!,
        name: json["Name"]!,
        nationalId: json["NationalID"]!,
        passengerType: json["PassengerType"]!,
        classType: json["ClassType"]!,
        firstName: json["FirstName"]!,
        lastName: json["LastName"]!,
        passengerClass: json["Class"]!,
        title: json["Title"]!,
        docsBirthDate: DateTime.parse(json["DocsBirthDate"]),
        docsTitle: json["DocsTitle"]!,
        flightScheduleId: json["FlightScheduleID"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Reference": reference,
        "Name": name,
        "NationalID": nationalId,
        "PassengerType": passengerType,
        "ClassType": classType,
        "FirstName": firstName,
        "LastName": lastName,
        "Class": passengerClass,
        "Title": title,
        "DocsBirthDate": "${docsBirthDate.year.toString().padLeft(4, '0')}-${docsBirthDate.month.toString().padLeft(2, '0')}-${docsBirthDate.day.toString().padLeft(2, '0')}",
        "DocsTitle": docsTitle,
        "FlightScheduleID": flightScheduleId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
