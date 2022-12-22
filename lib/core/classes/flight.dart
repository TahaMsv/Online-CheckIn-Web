class Flight {
  Flight({
    // required this.id,
    required this.aircraft,
    required this.fromCity,
    required this.toCity,
    required this.fromCityName,
    required this.toCityName,
    required this.fromTime,
    required this.toTime,
    // required this.attendanceTime,
    required this.flightDate,
    required this.terminal,
    // required this.weightAdl,
    // required this.weightChd,
    // required this.weightInf,
    // required this.al,
    // required this.dayOfWeek,
    // required this.flnb,
    // required this.aircraftId,
    // required this.alName,
    // required this.aircraftShowName,
    required this.boardingTime,
    required this.checkDocs,
  });

  // int id;
  String aircraft;
  String fromCity;
  String toCity;
  String fromCityName;
  String toCityName;
  String fromTime;
  String toTime;

  // String attendanceTime;
  DateTime flightDate;
  int terminal;

  // int weightAdl;
  // int weightChd;
  // int weightInf;
  // String al;
  // String dayOfWeek;
  // String flnb;
  // int aircraftId;
  // String alName;
  // String aircraftShowName;
  String boardingTime;
  int checkDocs;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
    // id: json["ID"],
    aircraft: json["Aircraft"],
    fromCity: json["From_City"],
    toCity: json["To_City"],
    fromCityName: json["From_CityName"],
    toCityName: json["To_CityName"],
    fromTime: json["From_Time"],
    toTime: json["To_Time"],
    // attendanceTime: json["AttendanceTime"],
    flightDate: DateTime.parse(json["FlightDate"]),
    terminal: json["Terminal"],
    // weightAdl: json["Weight_ADL"],
    // weightChd: json["Weight_CHD"],
    // weightInf: json["Weight_INF"],
    // al: json["AL"],
    // dayOfWeek: json["DayOfWeek"],
    // flnb: json["FLNB"],
    // aircraftId: json["AircraftID"],
    // alName: json["AL_Name"],
    // aircraftShowName: json["AircraftShowName"],
    boardingTime: json["BoardingTime"],
    checkDocs: json["CheckDocs"],
  );

  Map<String, dynamic> toJson() => {
    // "ID": id,
    "Aircraft": aircraft,
    "From_City": fromCity,
    "To_City": toCity,
    "From_CityName": fromCityName,
    "To_CityName": toCityName,
    "From_Time": fromTime,
    "To_Time": toTime,
    // "AttendanceTime": attendanceTime,
    "FlightDate": "${flightDate.year.toString().padLeft(4, '0')}-${flightDate.month.toString().padLeft(2, '0')}-${flightDate.day.toString().padLeft(2, '0')}",
    "Terminal": terminal,
    // "Weight_ADL": weightAdl,
    // "Weight_CHD": weightChd,
    // "Weight_INF": weightInf,
    // "AL": al,
    // "DayOfWeek": dayOfWeek,
    // "FLNB": flnb,
    // "AircraftID": aircraftId,
    // "AL_Name": alName,
    // "AircraftShowName": aircraftShowName,
    "BoardingTime": boardingTime,
    "CheckDocs": checkDocs,
  };
}
