class Passenger {
  Passenger({
    required this.id,
    // required this.reference,
    required this.name,
    // required this.nationalId,
    // required this.passengerType,
    required this.classType,
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
  String classType;
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
        classType: json["ClassType"],
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
        "ClassType": classType,
        "FirstName": firstName,
        "LastName": lastName,
        // "Class": passengerClass,
        "Title": title,
        "DocsTitle": docsTitle,
        // "FlightScheduleID": flightScheduleId,
      };

  String get cabin => classType == "E"
      ? "Economy"
      : classType == "F"
          ? "First Class"
          : classType == "B"
              ? "Business"
              : classType;
}
