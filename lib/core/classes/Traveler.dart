import 'package:online_check_in/core/classes/passenger.dart';

import 'PassportInfo.dart';
import 'VisaInfo.dart';
import 'flight_information.dart';

class Traveler {
  late String token;
  late String ticketNumber;
  late String seatId;
  late PassportInfo _passportInfo;
  late FlightInformation flightInformation;

  late VisaInfo _visaInfo;

  Traveler({
    required this.token,
    required this.ticketNumber,
    required this.seatId,
    required this.flightInformation,
  });

  String getNickName() {
    Passenger passengerInfo = flightInformation.passengers.last;
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
    Passenger passengerInfo = flightInformation.passengers.last;
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

  factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
    token: json["token"],
    ticketNumber: json["ticketNumber"],
    seatId: json["seatId"],
    // passportInfo: PassportInfo.fromJson(json["passportInfo"]),
    flightInformation: FlightInformation.fromJson(json["flightInformation"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "ticketNumber": ticketNumber,
    "seatId": seatId,
    // "passportInfo": passportInfo.toJson(),
    "flightInformation": flightInformation.toJson(),
  };
}