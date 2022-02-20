// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Traveller {
  late String token;
  late String ticketNumber;
  late String seatId;
  late PassportInfo _passportInfo;
  late Welcome welcome;

  late VisaInfo _visaInfo;

  Traveller({
    required this.token,
    required this.ticketNumber,
    required this.seatId,
    required this.welcome,
  });

  String getNickName() {
    Passenger passengerInfo=welcome.body.passengers[0];
    String travellerFullName = passengerInfo.name;
    int idx = travellerFullName.indexOf(" ");
    String nickname = "";
    if (idx == -1) {
      nickname = travellerFullName.substring(0, 1).toUpperCase();
    } else {
      List<String> nameParts = [travellerFullName.substring(0, idx).trim(), travellerFullName.substring(idx + 1).trim()];
      nickname = (nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1)).toUpperCase();
    }
    return nickname;
  }

  String getFullNameWithGender() {
    Passenger passengerInfo=welcome.body.passengers[0];
    String result = "";
    result = (passengerInfo.title == "MR" ? "Mr. " : "Ms. ");
    result += (passengerInfo.name);
    return result;
  }

  VisaInfo get visaInfo => _visaInfo;

  void setVisaInfo(VisaInfo value) {
    _visaInfo = value;
  }

  PassportInfo get passportInfo => _passportInfo;

  void setPassportInfo(PassportInfo value) {
    _passportInfo = value;
  }
}

class PassportInfo {
  late bool isPassInfoCompleted = false;
  late String? passportType;
  late String? documentNo;
  late String? gender;
  late String? countryOfIssue;
  late String? nationality;
  late DateTime? dateOfBirth;
  late DateTime? entryDate;
  late String? nationalityID;

  PassportInfo({
    this.passportType,
    this.documentNo,
    this.gender,
    this.countryOfIssue,
    this.nationality,
    this.dateOfBirth,
    this.entryDate,
  });

  bool updateIsCompleted() {
    isPassInfoCompleted = passportType != null && documentNo != null && gender != null && countryOfIssue != null && nationality != null && dateOfBirth != null && entryDate != null;
    return isPassInfoCompleted;
  }
}

class VisaInfo {
  late bool isVisaInfoCompleted = false;
  late String? type;
  late String? documentNo;
  late String? placeOfIssue;
  late String? destination;
  late DateTime? issueDate;
  late String? placeOfIssueID;

  VisaInfo({
    this.type,
    this.documentNo,
    this.placeOfIssue,
    this.destination,
    this.issueDate,
  });

  bool updateIsCompleted() {
    isVisaInfoCompleted = type != null && documentNo != null && placeOfIssue != null && destination != null && issueDate != null;
    print(type == null);
    print(documentNo == null);
    print(destination == null);
    print(destination == null);
    print(issueDate == null);
    print(isVisaInfoCompleted);
    return isVisaInfoCompleted;
  }
}

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
}

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
}

class Country {
  Country({
    required this.id,
    required this.code3,
    required this.name,
    required this.englishName,
    required this.worldAreaCode,
    required this.currencyId,
    required this.regionId,
    required this.hasOnHoldBooking,
    required this.isDisabled,
  });

  String? id;
  String? code3;
  String? name;
  String? englishName;
  String? worldAreaCode;
  String? currencyId;
  int? regionId;
  bool? hasOnHoldBooking;
  bool? isDisabled;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["ID"] == null ? null : json["ID"],
        code3: json["Code3"] == null ? null : json["Code3"],
        name: json["Name"] == null ? null : json["Name"],
        englishName: json["EnglishName"] == null ? null : json["EnglishName"],
        worldAreaCode: json["World_Area_Code"] == null ? null : json["World_Area_Code"],
        currencyId: json["CurrencyID"] == null ? null : json["CurrencyID"],
        regionId: json["RegionID"] == null ? null : json["RegionID"],
        hasOnHoldBooking: json["HasOnHoldBooking"] == null ? null : json["HasOnHoldBooking"],
        isDisabled: json["IsDisabled"] == null ? null : json["IsDisabled"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Code3": code3,
        "Name": name,
        "EnglishName": englishName,
        "World_Area_Code": worldAreaCode == null ? null : worldAreaCode,
        "CurrencyID": currencyId == null ? null : currencyId,
        "RegionID": regionId == null ? null : regionId,
        "HasOnHoldBooking": hasOnHoldBooking == null ? null : hasOnHoldBooking,
        "IsDisabled": isDisabled == null ? null : isDisabled,
      };
}
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.resultCode,
    required this.resultText,
    required this.body,
  });

  int resultCode;
  String resultText;
  Body body;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        resultCode: json["ResultCode"],
        resultText: json["ResultText"],
        body: Body.fromJson(json["Body"]),
      );

  Map<String, dynamic> toJson() => {
        "ResultCode": resultCode,
        "ResultText": resultText,
        "Body": body.toJson(),
      };
}

class Body {
  Body({
    required this.flight,
    required this.passengers,
    required this.seats,
    required this.seatmap,
  });

  List<Flight> flight;
  List<Passenger> passengers;
  List<Seat> seats;
  SeatMap seatmap;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        flight: List<Flight>.from(json["Flight"].map((x) => Flight.fromJson(x))),
        passengers: List<Passenger>.from(json["Passengers"].map((x) => Passenger.fromJson(x))),
        seats: List<Seat>.from(json["Seats"].map((x) => Seat.fromJson(x))),
        seatmap: SeatMap.fromJson(json["Seatmap"]),
      );

  Map<String, dynamic> toJson() => {
        "Flight": List<dynamic>.from(flight.map((x) => x.toJson())),
        "Passengers": List<dynamic>.from(passengers.map((x) => x.toJson())),
        "Seats": List<dynamic>.from(seats.map((x) => x.toJson())),
        "Seatmap": seatmap.toJson(),
      };
}

class Flight {
  Flight({
    // required this.id,
    // required this.aircraft,
    required this.fromCity,
    required this.toCity,
    // required this.fromCityName,
    // required this.toCityName,
    // required this.fromTime,
    // required this.toTime,
    // required this.attendanceTime,
    // required this.flightDate,
    // required this.terminal,
    // required this.weightAdl,
    // required this.weightChd,
    // required this.weightInf,
    // required this.al,
    // required this.dayOfWeek,
    // required this.flnb,
    // required this.aircraftId,
    // required this.alName,
    // required this.aircraftShowName,
    // required this.boardingTime,
    required this.checkDocs,
  });

  // int id;
  // String aircraft;
  String fromCity;
  String toCity;
  // String fromCityName;
  // String toCityName;
  // String fromTime;
  // String toTime;
  // String attendanceTime;
  // DateTime flightDate;
  // int terminal;
  // int weightAdl;
  // int weightChd;
  // int weightInf;
  // String al;
  // String dayOfWeek;
  // String flnb;
  // int aircraftId;
  // String alName;
  // String aircraftShowName;
  // String boardingTime;
  bool checkDocs;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        // id: json["ID"],
        // aircraft: json["Aircraft"],
        fromCity: json["From_City"],
        toCity: json["To_City"],
        // fromCityName: json["From_CityName"],
        // toCityName: json["To_CityName"],
        // fromTime: json["From_Time"],
        // toTime: json["To_Time"],
        // attendanceTime: json["AttendanceTime"],
        // flightDate: DateTime.parse(json["FlightDate"]),
        // terminal: json["Terminal"],
        // weightAdl: json["Weight_ADL"],
        // weightChd: json["Weight_CHD"],
        // weightInf: json["Weight_INF"],
        // al: json["AL"],
        // dayOfWeek: json["DayOfWeek"],
        // flnb: json["FLNB"],
        // aircraftId: json["AircraftID"],
        // alName: json["AL_Name"],
        // aircraftShowName: json["AircraftShowName"],
        // boardingTime: json["BoardingTime"],
        checkDocs: json["CheckDocs"],
      );

  Map<String, dynamic> toJson() => {
        // "ID": id,
        // "Aircraft": aircraft,
        "From_City": fromCity,
        "To_City": toCity,
        // "From_CityName": fromCityName,
        // "To_CityName": toCityName,
        // "From_Time": fromTime,
        // "To_Time": toTime,
        // "AttendanceTime": attendanceTime,
        // "FlightDate": "${flightDate.year.toString().padLeft(4, '0')}-${flightDate.month.toString().padLeft(2, '0')}-${flightDate.day.toString().padLeft(2, '0')}",
        // "Terminal": terminal,
        // "Weight_ADL": weightAdl,
        // "Weight_CHD": weightChd,
        // "Weight_INF": weightInf,
        // "AL": al,
        // "DayOfWeek": dayOfWeek,
        // "FLNB": flnb,
        // "AircraftID": aircraftId,
        // "AL_Name": alName,
        // "AircraftShowName": aircraftShowName,
        // "BoardingTime": boardingTime,
        "CheckDocs": checkDocs,
      };
}

class Passenger {
  Passenger({
    required this.id,
    // required this.reference,
    required this.name,
    // required this.nationalId,
    // required this.passengerType,
    // required this.classType,
    required this.firstName,
    required this.lastName,
    // required this.passengerClass,
    required this.title,
    required this.docsTitle,
    // required this.flightScheduleId,
  });

  int id;
  // String reference;
  String name;
  // String nationalId;
  // String passengerType;
  // String classType;
  String firstName;
  String lastName;
  // String passengerClass;
  String title;
  String docsTitle;
  // int flightScheduleId;

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        id: json["ID"],
        // reference: json["Reference"],
        name: json["Name"],
        // nationalId: json["NationalID"],
        // passengerType: json["PassengerType"],
        // classType: json["ClassType"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        // passengerClass: json["Class"],
        title: json["Title"],
        docsTitle: json["DocsTitle"],
        // flightScheduleId: json["FlightScheduleID"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        // "Reference": reference,
        "Name": name,
        // "NationalID": nationalId,
        // "PassengerType": passengerType,
        // "ClassType": classType,
        "FirstName": firstName,
        "LastName": lastName,
        // "Class": passengerClass,
        "Title": title,
        "DocsTitle": docsTitle,
        // "FlightScheduleID": flightScheduleId,
      };
}

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

// enum SeatProperty { SEAT, VERTICAL_CODE, OUT_EQUIPMENT_WING, OUT_EQUIPMENT_EXIT, AILE }
//
// final seatPropertyValues = EnumValues({
//   "Aile": SeatProperty.AILE,
//   "OutEquipmentExit": SeatProperty.OUT_EQUIPMENT_EXIT,
//   "OutEquipmentWing": SeatProperty.OUT_EQUIPMENT_WING,
//   "Seat": SeatProperty.SEAT,
//   "VerticalCode": SeatProperty.VERTICAL_CODE
// });

// enum Type { HORIZONTAL_CODE, BODY }
//
// final typeValues = EnumValues({
//   "Body": Type.BODY,
//   "HorizontalCode": Type.HORIZONTAL_CODE
// });

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
    required this.price,
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
  int price;

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
        price: json["Price"],
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


class Extra {
  Extra({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.image,
  });

  int id;
  String title;
  String description;
  String imageUrl;
  double price;
  String image;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    id: json["Id"],
    title: json["Title"],
    description: json["Description"],
    imageUrl: json["ImageUrl"],
    price: json["Price"].toDouble(),
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Title": title,
    "Description": description,
    "ImageUrl": imageUrl,
    "Price": price,
    "Image": image,
  };
}

class BoardingPassPDF {
  BoardingPassPDF({
    required this.buffer,
    // required this.origin,
    // required this.position,
    // required this.length,
    // required this.capacity,
    // required this.expandable,
    // required this.writable,
    // required this.exposable,
    // required this.isOpen,
    // required this.identity,
  });

  String buffer;
  // int origin;
  // int position;
  // int length;
  // int capacity;
  // bool expandable;
  // bool writable;
  // bool exposable;
  // bool isOpen;
  // dynamic identity;

  factory BoardingPassPDF.fromJson(Map<String, dynamic> json) => BoardingPassPDF(
    buffer: json["_buffer"],
    // origin: json["_origin"],
    // position: json["_position"],
    // length: json["_length"],
    // capacity: json["_capacity"],
    // expandable: json["_expandable"],
    // writable: json["_writable"],
    // exposable: json["_exposable"],
    // isOpen: json["_isOpen"],
    // identity: json["__identity"],
  );

  Map<String, dynamic> toJson() => {
    "_buffer": buffer,
    // "_origin": origin,
    // "_position": position,
    // "_length": length,
    // "_capacity": capacity,
    // "_expandable": expandable,
    // "_writable": writable,
    // "_exposable": exposable,
    // "_isOpen": isOpen,
    // "__identity": identity,
  };
}


// enum CellStatusType { NONE }
//
// final cellStatusTypeValues = EnumValues({
//   "None": CellStatusType.NONE
// });

// enum CellType { VERTICAL_CODE, OUT_EQUIPMENT_WING, OUT_EQUIPMENT_EXIT, SEAT, AILE }

// final cellTypeValues = EnumValues({
//   "Aile": CellType.AILE,
//   "OutEquipmentExit": CellType.OUT_EQUIPMENT_EXIT,
//   "OutEquipmentWing": CellType.OUT_EQUIPMENT_WING,
//   "Seat": CellType.SEAT,
//   "VerticalCode": CellType.VERTICAL_CODE
// });

// enum LineType { HORIZONTAL_CODE, BODY }
//
// final lineTypeValues = EnumValues({
//   "Body": LineType.BODY,
//   "HorizontalCode": LineType.HORIZONTAL_CODE
// });
